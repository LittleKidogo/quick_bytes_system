defmodule QbBackend.Repo.Migrations.CreateManualTags do
  use Ecto.Migration
  def change do
    create table(:manual_tags) do
      add :tag_id, references(:manuals, on_delete: :nothing, type: :binary_id)
      add :manual_id, references(:tags, on_delete: :nothing, type: :binary_id)
      timestamps(inserted_at: :added_on, updated_at: :edited_on)
    end
    create unique_index(:manual_tags, [:tag_id, :manual_id])
  end
end
