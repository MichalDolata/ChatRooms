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
      {:error, _} ->
        conn
        |> redirect(to: page_path(conn, :login))
    end
  end

  def create(conn, params) do
    case Accounts.create_user(:email, params) do
      _ -> redirect(conn, to: "/register")
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
        # TODO
        redirect(conn, to: "/login")
    end
  end

  defp auth_session(conn, %Accounts.User{} = user) do
    conn
    |> put_session(:current_user_id, user.id)
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: page_path(conn, :login))
  end
end