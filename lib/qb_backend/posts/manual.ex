defmodule QbBackend.Posts.Manual do
  @moduledoc """
  This module holds changeset used to work with the manual
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias QbBackend.{
    Accounts.Profile,
    Posts.Manual,
    Posts.Tag,
    Posts.Bookmark
  }

  @type t :: %__MODULE__{}

  # binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "manuals" do
    field(:title, :string)
    field(:body, :string)
    belongs_to(:profile, Profile, foreign_key: :profile_id, type: :binary_id)
    belongs_to(:bookmark, Bookmark, foreign_key: :bookmark_id, type: :binary_id, on_replace: :delete)

    many_to_many(
      :tags,
      Tag,
      join_through: "manuals_tags",
      join_keys: [manual_id: :id, tag_id: :id],
      on_replace: :delete
    )
  end

  @doc """
    This changeset takes in a struct and a map containing parameters
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
@doc """
  This function takes a bookmark and a manual and creates an association between them
  """
  @spec add_to_bookmark(Manual.t(), Bookmark.t()) :: {:ok, Manual.t()} | {:error, Ecto.Changeset.t()}
  def add_to_bookmark(%Manual{} = manual, %Bookmark{} = bookmark) do
    manual
    |> changeset(%{})
    |> put_assoc(:bookmark, bookmark)
  end

  @doc """
  This function  takes an item and removes the cart association from it
  """
  @spec remove_manual_from_bookmark(Manual.t()) :: {:ok, Itemual.t()} | {:error, Ecto.Changeset.t()}
  def remove_manual_from_bookmark(%Manual{bookmark: _bkmark} = manual) do
    manual
    |> changeset(%{})
    |> put_change(:bookmark_id, nil)
    |> put_change(:bookmark, nil)
  end



end
