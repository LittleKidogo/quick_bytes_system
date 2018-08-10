defmodule QbBackend.Repo.Migrations.AssociateImageToManual do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :manual_id, references(:manuals, type: :binary_id)
    end

    create index(:images, [:manual_id])
  end
end
