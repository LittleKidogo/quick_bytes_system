defmodule QbBackend.Posts.BookmarkTest do
  @moduledoc """
  this module comprises for tests for the bookmark model
  """

  use QbBackend.DataCase

  alias QbBackend.{
    Posts.Bookmark,
    Posts.Manual,
    Repo

    }
    @valid_bookmark %{}
  describe "Bookmark" do
    test "Enable a user to create a bookmark" do
      changeset = Bookmark.changeset(%Bookmark{}, @valid_bookmark)
      assert changeset.valid?
    end

    test "associate bookmark to user profile" do
      profile = insert(:profile)
      changeset = Bookmark.create_bookmark_with_profile(profile, @valid_bookmark)
      assert changeset.valid?
      assert changeset.changes.profile
    end

    test "add manual to bookmark and associate a manual to a bookmark" do
     bookmark = insert(:bookmark)
     manual = insert(:manual)
     assert Repo.aggregate(Manual, :count, :id) == 1
     assert Repo.aggregate(Bookmark, :count, :id) == 1
     loaded_bookmark = bookmark |> Repo.preload(:manuals)
     changeset = Bookmark.add_manual_to_bookmark(loaded_bookmark, manual)
     assert changeset.valid?
     assert changeset.changes.manuals
    end

    test "remove manual from a bookmark" do
      bookmark = insert(:bookmark)
      manual = insert(:manual)
      assert Repo.aggregate(Manual, :count, :id) ==1
      assert Repo.aggregate(Bookmark, :count, :id) == 1
      loaded_bookmark = bookmark |> Repo.preload(:manuals)
      {:ok, manual_bookmarked} = loaded_bookmark |> Bookmark.add_manual_to_bookmark(manual) |> Repo.update()
      changeset = Bookmark.remove_manual_from_bookmark(manual_bookmarked, manual)
      assert changeset.valid?
    end
  end
end
