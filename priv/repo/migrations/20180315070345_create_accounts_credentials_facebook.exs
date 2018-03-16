defmodule ChatRooms.Repo.Migrations.CreateAccountsCredentialsFacebook do
  use Ecto.Migration

  def change do
    create table(:accounts_credentials_facebook) do
      add :fb_id, :string 

      add :user_id, references("accounts_users")
      timestamps()
    end

    create unique_index(:accounts_credentials_facebook, [:fb_id])
  end
end
