defmodule QbBackend.Posts.Manual do
  @moduledoc """
  This module holds changeset used to work with the manual
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias QbBackend.{
    Accounts.Profile,
    Posts.Manual
    }

  @type t :: %__MODULE__{}

  #binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "manuals" do
    field :title, :string
    field :body, :string
    belongs_to :profile, Profile, foreign_key: :profile_id, type: :binary_id
  end

  @doc """
    This changeset takes in a struct and a map containig parameters
    and proceeds to match the parameters in the map to the schema above
  """
  @spec changeset(Manual.t(), map()) :: Ecto.Changeset.t()
  def changeset(manual, attrs \\ %{}) do
    manual
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
    |> validate_length(:title, max: 60)
  end

  @doc """
  This changeset takes in the profile struct and a map containing parameters
  and proceeds to match the parameters in the map to the schema above
"""
  @spec create_changeset(Profile.t(), map()) :: Ecto.Changeset.t()
  def create_changeset(%Profile{} = profile, attrs) do
    %Manual{}
    |> Manual.changeset(attrs)
    |> put_assoc(:profile, profile)
  end
end
