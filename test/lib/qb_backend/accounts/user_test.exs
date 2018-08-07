defmodule QbBackend.Accounts.UserTest do
  @moduledoc """
  This module contains unit tests for the User Changesets
  """
  use QbBackend.DataCase

  alias QbBackend.{
    Accounts.User
  }

  @valid_attrs %{name: "Zacck Osiemo", hash: "18y7391heqiuhr2iurebqubd2"}
  @name_attrs %{name: "Zacck"}
  @hash_attrs %{hash: "nfnwidon;wfnwj"}
  describe "user changesets" do
    test "valid with correct parameters" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "invalid if hash is missing" do
      changeset = User.changeset(%User{}, @name_attrs)
      refute changeset.valid?
    end

    test "invalid if name is missing" do
      changeset = User.changeset(%User{}, @hash_attrs)
      refute changeset.valid?
    end
  end
end
