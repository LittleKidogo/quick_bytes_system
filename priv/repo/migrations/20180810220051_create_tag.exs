defmodule QbBackend.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps(inserted_at: :added_on)
    end

  end
end

