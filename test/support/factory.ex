defmodule QbBackend.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: QbBackend.Repo

  alias QbBackend.{
    Accounts.User
  }

  def user_factory do
    %User{
      name: sequence(:name, &"name-#{&1}")
    }
  end

end
