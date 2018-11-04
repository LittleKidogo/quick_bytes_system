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

    many_to_many(
      :bookmarks, Bookmark,
      join_through: "bookmarks_manuals",
      join_keys: [manual_id: :id, bookmark_id: :id],
      on_replace: :delete)

    many_to_many(
      :tags, Tag,
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
  This function takes a manual and a bookmark and creates an association between them

  Parameters:
  * `bookmark` - a valid bookmark in the system
  * `manual` - a valid manual in the system
  """
  @spec add_to_bookmark(Manual.t(), Bookmark.t()) :: {:ok, Bookmark.t()} | {:error, Ecto.Changeset.t()}
  def add_to_bookmark(%Manual{id: _id, bookmarks: bookmarks} = manual, %Bookmark{} = bookmark) do
    manual
    |> changeset(%{})
    |> put_assoc(:bookmarks, bookmarks ++ [bookmark])
  end
end
