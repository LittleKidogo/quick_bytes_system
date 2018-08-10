defmodule QbBackend.Posts.ManualTest do
  @moduledoc """
  This module holds tests for the manual changesets
  """
  use QbBackend.DataCase

  alias QbBackend.{
    Posts.Manual,
  }

  @valid_manual %{title: "1,000 ways to die", body: " 1. Death by paperbag"}
  @title_attrs %{title: "1,000 ways to die"}
  @body_attrs %{body: "1. Death by paperbag"}

  describe "Manual tests" do
    test "Valid if all parameters are provided" do
      changeset = Manual.changeset(%Manual{}, @valid_manual)
      assert changeset.valid?
    end

    test "Invalid if the title is missing" do
      changeset = Manual.changeset(%Manual{}, @title_attrs)
      refute changeset.valid?
    end

    test "Invalid if the body is missing" do
      changeset = Manual.changeset(%Manual{}, @body_attrs)
      refute changeset.valid?
    end

    test "create_changeset will create an LogCategory associated to moneylog" do
      profile = insert(:profile)
      changeset = Manual.create_changeset(profile, @valid_manual)
      assert changeset.valid?
      assert changeset.changes.profile
     end
  end
end
