defmodule QbBackend.Repo.Migrations.EnableTheBackendToSaveEditAndPublishManuals do
  use Ecto.Migration

  def change do
    create table(:manuals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :body, :string
      add :profile_id, references(:profiles, on_delete: :nothing, type: :binary_id)
  end
 end
end