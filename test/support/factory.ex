defmodule QbBackend.Factory do
  @moduledoc """
  This module holds factories for test data in the application
  """
  use ExMachina.Ecto, repo: QbBackend.Repo

  alias QbBackend.{
    Accounts.User,
    Accounts.Profile
  }

  def user_factory do
    %User{
      name: sequence(:name, &"name-#{&1}"),
      hash: sequence(:hash, &"hash-#{&1}")
    }
  end

  def profile_factory do
    %Profile{
      username: sequence(:username, &"username-#{&1}"),
      bio: "This is a biography",
      role: sequence(:role, ["reader", "author", "publisher"]),
      avatar_link: sequence(:avatar_link, &"link-#{&1}"),
      user: build(:user)
    }
  end
end
