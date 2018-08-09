defmodule QbBackend.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :body, :string
      add :profile_id, references(:profiles, type: :binary_id)

      timestamps()
    end

  end
end
