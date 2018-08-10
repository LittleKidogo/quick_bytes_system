defmodule QbBackend.AuthTest do
  @moduledoc """
  This module holds unit tests for functions in the accounts context
  """
  use QbBackend.DataCase

  alias QbBackend.{
    Auth,
    Accounts.User,
    Accounts.Profile
  }

  @creds %{name: "Zacck", hash: "hash"}
  @profile_creds %{username: "superbike_z", role: "publisher"}
  describe "Auth Context" do
    @tag :simple
    test "authenticate/2  returns a user if one exists for the plain password" do
      {:ok, user} = %User{} |> User.changeset(@creds)|> Repo.insert()
      {:ok, profile} = Profile.create_changeset(user, @profile_creds) |> Repo.insert()
      {:ok, %Profile{} = prof} = Auth.authenticate(profile.username, @creds[:hash])
      assert prof.username == @profile_creds[:username]
    end

    test "authenticate/2  returns an error if a corresponding user doesnt exist" do
      assert Repo.aggregate(User, :count, :id) == 0
      assert {:error, "Access Denied - Invalid Authentication Details"} = Auth.authenticate("a5f13624-f084-4297-b67f-9e276945cc99", @creds[:hash])
    end
  end

end
