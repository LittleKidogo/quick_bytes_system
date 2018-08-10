defmodule QbBackend.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :body, :string
      add :profile_id, references(:profiles, type: :binary_id)

      timestamps(inserted_at: :added_on, updated_at: :edited_on)
    end

    create index(:comments, [:profile_id])
  end
end
