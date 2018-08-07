defmodule QbBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :hash, :string

      timestamps(inserted_at: :joined_on, updated_at: :updated_at)
    end
  end
end
