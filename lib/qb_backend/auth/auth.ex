defmodule QbBackend.Auth do
  @moduledoc """
  This module is the Authentication context boundary
  """
  import Ecto.Query, only: [from: 2]
  alias Comeonin.Bcrypt
  alias QbBackend.{
    Accounts.User,
    Accounts.Profile,
    Repo
  }

  @doc """
  This function takes a user id and a plain text password and proceeds to check
  if the user is valid
  """
  def authenticate(username, plain_text_password) do
    query = from p in Profile, where: p.username == ^username

    Repo.one(query)
    |> Repo.preload(:user)
    |> check_password(plain_text_password)
  end

  @spec check_password(User.t(), String.t()) :: {:ok, User.t()} | {:error, String.t()}
  defp check_password(nil, _),  do: {:error, "Access Denied - Invalid Authentication Details"}

  defp check_password(profile, pass) do
    with true <- Bcrypt.checkpw(pass, profile.user.hash) do
      {:ok, profile}
    else
      false -> {:error, "Access Denied - Invalid Authentication Details"}
    end
  end
end
