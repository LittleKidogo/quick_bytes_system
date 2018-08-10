defmodule QbBackend.Repo.Migrations.AssociateCommentsToManual do
  @moduledoc """
  this migration associates comments to manuals
  """
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :manual_id, references(:manuals, type: :binary_id)
    end

    create index(:comments, [:manual_id])

  end
end
