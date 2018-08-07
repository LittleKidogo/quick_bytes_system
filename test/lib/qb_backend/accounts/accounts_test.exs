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
  describe "Accounts Context " do
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
  end
end
