defmodule QbBackend.Repo.Migrations.CreateBookmark do
  use Ecto.Migration

  def change do
    create table(:bookmarks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :manual_id, references(:manuals, type: :binary_id)
      add :profile_id, references(:profiles, type: :binary_id)
      add :category, :string

      timestamps(inserted_at: :added_on, updated_at: :updated_on)
    end
    create index(:bookmarks, [:manual_id])
  end
end
