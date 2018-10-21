defmodule QbBackend.Posts.Bookmark do
  @moduledoc """
  This module defines the schema for the bookmark section
  """
  use QbBackend.Utils.Schema

  alias QbBackend.{
    Posts.Manual,
    Accounts.Profile,
    Posts.Bookmark
  }

  schema "bookmarks" do
    has_many(:manuals, Manual, on_replace: :delete)
    belongs_to(:profile, Profile, foreign_key: :profile_id, type: :binary_id)

    timestamps(inserted_at: :added_on, updated_at: :updated_on)
  end

  @doc """
  This changeset function creates a bookmark
  """
  @spec changeset(Bookmark.t(), map) :: {:ok, Bookmark.t()}|{:error, Ecto.Changeset.t()}
  def changeset(%Bookmark{} = bookmark, params) do
    bookmark
    |> cast(params, [])
  end

  @doc """
  This function takes a user profile and a manual and adds the bookmark
  """
  @spec create_bookmark_with_profile(Profile.t(), map) :: {:ok, Bookmark.t()} | {:error, Ecto.Changeset}
  def create_bookmark_with_profile(%Profile{} = profile, params) do
    %Bookmark{}
    |> changeset(params)
    |> put_assoc(:profile, profile)
  end

  @doc """
  This function adds a manual to a bookmark and associates them
  """
  @spec add_manual_to_bookmark(Bookmark.t(), Manual.t()) :: {:ok, Bookmark.t()}|{:error, Ecto.Changeset.t()}
  def add_manual_to_bookmark(%Bookmark{id: _id, manuals: manuals} = bookmark, %Manual{} = manual) do
    bookmark
    |> changeset(%{})
    |> put_assoc(:manuals, manuals ++ [manual])
  end

  @doc """
  This function removes an already existing manual from the bookmark
  """
  @spec remove_manual_from_bookmark(Bookmark.t(), Manual.t())::{:ok, Bookmark.t()}| {:error, Ecto.Changeset.t()}
  def remove_manual_from_bookmark(%Bookmark{id: _id, manuals: manuals} = bookmark, %Manual{id: manual_id}) do
    remaining_manuals = Enum.filter(manuals, fn m -> m.id != manual_id end)
    
    bookmark
    |> changeset(%{})
    |> put_assoc(:manuals, remaining_manuals)
  end
end
