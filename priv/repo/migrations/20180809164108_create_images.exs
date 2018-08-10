defmodule QbBackend.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :image_link, :string
      #add :manual_id, references(:manuals, type: :binary_id)
      add :profile_id, references(:profiles, type: :binary_id)

      timestamps()
    end

  end
end
