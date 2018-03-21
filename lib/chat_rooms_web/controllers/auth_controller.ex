defmodule ChatRoomsWeb.AuthController do
  use ChatRoomsWeb, :controller
  plug Ueberauth
  alias ChatRooms.Accounts

  plug ChatRoomsWeb.RequireGuest when action in [:login, :create, :require]

  def login(conn, params) do
    case Accounts.auth_user(params) do
      {:ok, %Accounts.User{} = user} ->
        conn
        |> auth_session(user)
        |> redirect(to: page_path(conn, :chat))
      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: page_path(conn, :login))
    end
  end

  def create(conn, params) do
    case Accounts.create_user(:email, params) do
      {:ok, %Accounts.User{}} -> 
        conn
        |> put_flash(:info, "Created account")
        |> redirect(to: page_path(conn, :login))
      {:error, _, changeset, _} ->
        formated_errors = changeset |> format_errors()
        conn
        |> put_flash(:error, formated_errors)
        |> redirect(to: page_path(conn, :register))
    end
  end

  def callback(%{assigns: %{ueberauth_auth: ueberauth_auth}} = conn, _params) do
    auth_params = %{
      fb_id: ueberauth_auth.uid,
      name: ueberauth_auth.info.name
    }
    
    case Accounts.auth_user(auth_params) do
      {:ok, %Accounts.User{} = user} ->
        conn
        |> auth_session(user)
        |> redirect(to: page_path(conn, :chat))
      {:error, _, _, _} ->
        conn
        |> put_flash(:error, "We have encountered errors. Please try again")
        |> redirect(to: "/login")
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _}} = conn, _params) do
    conn
    |> put_flash(:error, "We have encountered errors. Please try again")
    |> redirect(to: "/login")
  end

  defp auth_session(conn, %Accounts.User{} = user) do
    conn
    |> put_session(:current_user_id, user.id)
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: page_path(conn, :login))
  end

  defp format_errors(%Ecto.Changeset{} = changeset) do
    changeset.errors
    |> Enum.reduce("", fn({key, {value, _}}, acc) ->
      acc <> "<br>" <> humanize(key) <> " " <> value
    end)
    |> String.trim_leading("<br>")
  end

  defp humanize(string) do
    string |> Atom.to_string() |> String.replace("_", " ") |> String.capitalize()
  end
end 