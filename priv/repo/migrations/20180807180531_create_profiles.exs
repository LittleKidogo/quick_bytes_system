defmodule QbBackend.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :bio, :string
      add :role, :string
      add :avatar_link, :string
      add :user_id, references(:users, type: :binary_id)

      timestamps(inserted_at: :created_on, updated_at: :modified_on)
    end

    create index(:profiles, [:user_id])
    create unique_index(:profiles, [:username])
  end
end
