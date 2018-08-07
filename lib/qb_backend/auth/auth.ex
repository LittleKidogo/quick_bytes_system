defmodule QbBackend.Auth do
  @moduledoc """
  This module is the Authentication context boundary
  """
  import Ecto.Query, only: [from: 2]
  alias Comeonin.Bcrypt
  alias QbBackend.{
    Accounts.User,
    Repo
  }

  @doc """
  This function takes a user id and a plain text password and proceeds to check
  if the user is valid
  """
  def authenticate(id, plain_text_password) do
    query = from u in User, where: u.id == ^id

    Repo.one(query) |> check_password(plain_text_password)
  end

  @spec check_password(User.t(), String.t()) :: {:ok, User.t()} | {:error, String.t()}
  defp check_password(nil, _),  do: {:error, "Access Denied - Invalid Authentication Details"}

  defp check_password(user, pass) do
    with true <- Bcrypt.checkpw(pass, user.hash) do
      {:ok, user}
    else
      false -> {:error, "Access Denied - Invalid Authentication Details"}
    end
  end
end
