defmodule QbBackend.Posts.CommentTest do
  @moduledoc """
  this module comprises for tests for the comments module
  """

  use QbBackend.DataCase

  alias QbBackend.{
    Posts.Comment,
    Accounts.Profile
  }

  @valid_params %{body: "To ensure that you pass all the tests,
  the best but dumbest thing to do is skipping and ignoring them tests all together.
  Then you'll be having nightmares of bugs you been getting."}
  @invalid_params %{}
  @updated_params %{body: "updated the comment"}


  describe "comments changesets" do
    test "valid comment" do
      changeset = Comment.changeset(%Comment{},@valid_params)
      assert changeset.valid?
    end

    test "invalid/blank comment" do
      changeset = Comment.changeset(%Comment{}, @invalid_params)
      refute changeset.valid?
    end

    test "comments update changeset" do
      changeset = Comment.create_changeset(%Profile{},@updated_params)
      assert changeset.valid?
    end
  end
end
