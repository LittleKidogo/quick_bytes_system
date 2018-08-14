defmodule QbBackend.AccountsTest do
  @moduledoc """
  This module holds unit tests for functions in the accounts context
  """
  use QbBackend.DataCase

  alias QbBackend.{
    Accounts,
    Accounts.User,
    Accounts.Profile
  }

  @valid_user_attrs %{name: "Zacck Osiemo", hash: "jkjbjbwiubu"}
  @valid_profile_attrs %{username: "superbike_z", role: "reader"}
  @id "a7062358-021d-4273-827a-87c38cb213fe"

  describe "Accounts Context " do
    test "get_user/1 gets a user if one exits" do
      user = insert(:user)
      assert Repo.aggregate(User, :count, :id) == 1
      assert {:ok, %User{} = usr} = Accounts.get_user(user.id)
      assert usr.id == user.id
    end

    test "get_user/1 errors out is user with id doesn't exist" do
      assert Repo.aggregate(User, :count, :id) == 0
      assert {:error, "No user with id #{@id} on the system"} == Accounts.get_user(@id)
    end

    @tag :profile
    test "get_profile/1 get a profile if one exists" do
      profile = insert(:profile)
      assert Repo.aggregate(Profile, :count, :id) == 1
      assert {:ok, %Profile{} = prof} = Accounts.get_profile(profile.id)
      assert prof.id == profile.id
    end

    @tag :profile
    test "get_profile/1 errors out is user with id doesn't exist" do
      assert Repo.aggregate(Profile, :count, :id) == 0
      assert {:error, "No Profile with id #{@id} on the system"} == Accounts.get_profile(@id)
    end

    test "create_user/1 creates user with correct attrs" do
      assert Repo.aggregate(User, :count, :id) == 0
      assert {:ok, %User{} = usr} = Accounts.create_user(@valid_user_attrs)
      assert Repo.aggregate(User, :count, :id) == 1
      assert usr.name == @valid_user_attrs[:name]
    end

    test "create_user/1 returns errors out if data is invalid" do
      assert Repo.aggregate(User, :count, :id) == 0
      assert {:error, _changeset} = Accounts.create_user(%{})
      assert Repo.aggregate(User, :count, :id) == 0
    end

    test "delete_user/1 deletes an exisiting user" do
      user = insert(:user)
      assert Repo.aggregate(User, :count, :id) == 1
      assert {:ok, _usr} = Accounts.delete_user(user)
      assert Repo.aggregate(User, :count, :id) == 0
    end

    test "update_user/2 updates an existing users details" do
      user = insert(:user)
      assert Repo.aggregate(User, :count, :id) == 1
      assert {:ok, %User{} = usr} = Accounts.update_user(user, @valid_user_attrs)
      assert usr.id == user.id
      assert usr.name != user.name
    end

    test "create_profile/2  creates a profile with correct attrs" do
      user = insert(:user)
      assert Repo.aggregate(Profile, :count, :id) == 0
      assert {:ok, %Profile{} = prf} = Accounts.create_profile(user, @valid_profile_attrs)
      assert Repo.aggregate(Profile, :count, :id) == 1
      assert prf.username == @valid_profile_attrs[:username]
      assert prf.role == @valid_profile_attrs[:role]
    end

    test "create_profile/2  errors out with invalid attrs" do
      user = insert(:user)
      assert Repo.aggregate(Profile, :count, :id) == 0
      assert {:error, _changeset} = Accounts.create_profile(user, %{})
      assert Repo.aggregate(Profile, :count, :id) == 0
    end

    test "update_profile/2 updates a profile" do
      profile = insert(:profile)
      assert Repo.aggregate(Profile, :count, :id) == 1
      {:ok, %Profile{} = prf} = Accounts.update_profile(profile, @valid_profile_attrs)
      assert Repo.aggregate(Profile, :count, :id) == 1
      assert prf.id == profile.id
      assert prf.username != profile.username
    end

    test "delete_profile/1 deletes a profile from the system" do
      profile = insert(:profile)
      assert Repo.aggregate(Profile, :count, :id) == 1
      {:ok, %Profile{} = deleted_prof} = Accounts.delete_profile(profile)
      assert Repo.aggregate(Profile, :count, :id) == 0
      assert deleted_prof.id == profile.id
    end
  end
end
