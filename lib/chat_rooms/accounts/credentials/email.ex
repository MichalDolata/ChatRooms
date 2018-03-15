defmodule ChatRooms.Accounts.Credentials.Email do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChatRooms.Accounts.User


  schema "accounts_credentials_email" do
    field :email, :string
    field :password, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
  end
end
