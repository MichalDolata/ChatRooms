defmodule ChatRooms.Accounts do
  alias ChatRooms.Accounts.User
  alias ChatRooms.Accounts.Credentials
  alias ChatRooms.Repo

  import Ecto.Query, warn: false
  require IEx

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def auth_user(%{fb_id: _} = params) do
    case get_fb_credentials(params.fb_id) do
      %Credentials.Facebook{} = credentials ->
        {:ok, credentials.user}
      nil ->
        create_user(:facebook, params)
    end
  end

  def auth_user(%{"email" => _, "password" => _} = params) do
    case get_email_credentials(params) do
      {:ok, %Credentials.Email{} = credentials} ->
        {:ok, credentials.user}
      {:error, message} ->
        IO.inspect(message)
    end
  end

  def create_user(provider, params) do
    user_changeset = User.changeset(%User{}, params)
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:user, user_changeset)
    |> Ecto.Multi.run(:credentials, fn %{user: user} ->
        Repo.insert(credentials_changeset(provider, params, user))
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{user: user}} -> {:ok, user}
      error -> error
    end
  end

  defp credentials_changeset(:facebook, params, user) do
    %Credentials.Facebook{}
    |> Credentials.Facebook.changeset(params, user)
  end

  defp credentials_changeset(:email, params, user) do
    %Credentials.Email{}
    |> Credentials.Email.changeset(params, user)
  end

  def get_fb_credentials(fb_id) do
    Repo.one(from c in Credentials.Facebook, 
      where: c.fb_id == ^fb_id,
      preload: [:user])
  end

  def get_email_credentials(params) do
    Repo.one(from c in Credentials.Email,
      where: c.email == ^params["email"],
      preload: [:user])
    |> Comeonin.Argon2.check_pass(params["password"])
  end

  # create
  # 
end