defmodule QbBackend.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: QbBackend.Repo

  alias QbBackend.{
    Accounts.User,
    Accounts.Profile
  }

  def user_factory do
    %User{
      name: sequence(:name, &"name-#{&1}")
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
