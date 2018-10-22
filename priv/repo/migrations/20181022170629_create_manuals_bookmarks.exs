defmodule QbBackend.Repo.Migrations.CreateManualsBookmarks do
  @moduledoc """
  Migrartion to create many to many association table for manuals and bookmarks
  """
  use Ecto.Migration

  def change do
    create table(:bookmarks_manuals) do
      add :manual_id, references(:manuals, type: :binary_id)
      add :bookmark_id, references(:bookmarks, type: :binary_id)
    end

    create unique_index(:bookmarks_manuals, [:manual_id, :bookmark_id]) 
  end
end
