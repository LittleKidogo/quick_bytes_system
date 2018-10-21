defmodule QbBackend.Repo.Migrations.CreateBookmark do
  use Ecto.Migration

  def change do
    create table(:bookmarks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :manual_id, references(:manuals, type: :binary_id)
      add :profile_id, references(:profiles, type: :binary_id)

      timestamps(inserted_at: :added_on, updated_at: :updated_on)
    end

    alter table(:manuals) do
      add :bookmark_id, references(:bookmarks, type: :binary_id)
    end

    create index(:bookmarks, [:manual_id])
    create index(:manuals, [:bookmark_id])
  end
end
