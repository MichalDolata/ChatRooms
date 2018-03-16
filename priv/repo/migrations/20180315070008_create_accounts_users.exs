defmodule ChatRooms.Repo.Migrations.CreateAccountsUsers do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :name, :string

      timestamps()
    end

    create unique_index(:accounts_users, [:name])
  end
end
