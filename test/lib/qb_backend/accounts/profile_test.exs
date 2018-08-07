defmodule QbBackend.Accounts.ProfileTest do
  @moduledoc """
  This module contains unit tests for the Profile Changesets
  """
  use QbBackend.DataCase

  alias QbBackend.{
    Accounts.Profile
  }

  @valid_attrs  %{username: "superbike_z", role: "publisher"}
  @invalid_attrs %{}
  describe "profile changesets" do
    test "valid when username is provided" do
      user = insert(:user)

      changeset = Profile.create_changeset(user, @valid_attrs)

      assert changeset.valid?
    end

    test "invalid when username or role missing" do
      user = insert(:user)

      changeset = Profile.create_changeset(user, @invalid_attrs)

      refute changeset.valid?
    end

    test " valid if role is accepted" do
      user = insert(:user)
      ["reader","author","publisher"] |> Enum.each(fn(role) ->
        payload = Map.put(@valid_attrs, :status, role)
        changeset = Profile.create_changeset(user, payload)
        assert changeset.valid?
      end)
    end

    test " invalid if role is not on accepted list" do
      user = insert(:user)
      ["liker","deleter","creator"] |> Enum.each(fn(role) ->
        payload = Map.put(@valid_attrs, :role, role)
        changeset = Profile.create_changeset(user, payload)
        refute changeset.valid?
      end)
    end
  end

end
