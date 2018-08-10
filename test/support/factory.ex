defmodule QbBackend.Factory do
  @moduledoc """
  This module holds factories for test data in the application
  """
  use ExMachina.Ecto, repo: QbBackend.Repo

  alias QbBackend.{
    Accounts.User,
    Accounts.Profile,
    Posts.Manual,
    Posts.Comment,
    Posts.Image
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

  def comment_factory do
    %Comment{
      body: sequence(:body, &"body-#{&1}"),
      profile: build(:profile)
    }
  end

  def manual_factory do
    %Manual{
      profile: build(:profile),
      title: sequence(:title, &"title-#{&1}"),
      body: sequence(:body, &"manual body -#{&1}")
    }
  end

  def image_factory do
    %Image{
      name: sequence(:name, &"name-#{&1}"),
      image_link: sequence(:image_link, &"#{&1}-image_link"),
      profile: build(:profile)
    }
  end
end
