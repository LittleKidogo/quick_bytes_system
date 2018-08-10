defmodule QbBackend.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :image_link, :string
      add :profile_id, references(:profiles, type: :binary_id)

      timestamps(inserted_at: :added_on, updated_at: :edited_on)
    end

  end
end
