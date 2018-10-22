defmodule QbBackend.Repo.Migrations.AssociateManualsToBookmark do
  use Ecto.Migration

  def change do
    alter table(:manuals) do
      add :bookmark_id, references(:bookmarks, type: :binary_id)
    end
  end
end
