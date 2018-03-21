defmodule ChatRooms.Accounts.Credentials.Email do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChatRooms.Accounts.User


  schema "accounts_credentials_email" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(email, attrs, user) do
    email
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
    |> put_pass_hash()
    |> put_assoc(:user, user)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, 
    changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
  defp put_pass_hash(changeset), do: changeset
end
