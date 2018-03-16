defmodule ChatRooms.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChatRooms.Accounts.Credentials


  schema "accounts_users" do
    field :name, :string

    has_one :credentials_email, Credentials.Email
    has_one :credentials_fb, Credentials.Facebook

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
