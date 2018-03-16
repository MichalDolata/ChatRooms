defmodule ChatRooms.Repo.Migrations.CreateAccountsCredentialsEmail do
  use Ecto.Migration

  def change do
    create table(:accounts_credentials_email) do
      add :email, :string
      add :password_hash, :string
      
      add :user_id, references("accounts_users")
      timestamps()
    end

    create unique_index(:accounts_credentials_email, [:email])
  end
end
