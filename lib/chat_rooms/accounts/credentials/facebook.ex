defmodule ChatRooms.Accounts.Credentials.Facebook do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChatRooms.Accounts.User

  schema "accounts_credentials_facebook" do
    field :fb_id, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(facebook, attrs, user) do
    facebook
    |> cast(attrs, [:fb_id])
    |> validate_required([:fb_id])
    |> unique_constraint(:fb_id)
    |> put_assoc(:user, user)
  end
end
