defmodule QbBackendWeb.Resolvers.Accounts do
  @moduledoc """
  A Module to hand web facing interactions for the accounts context
  """
  alias QbBackend.{
    Auth,
    Auth.Guardian,
    Accounts.User,
    Accounts.Profile,
    Accounts,
    Repo
  }

  @spec get_people(any(), map, any()) :: {:ok, list(Person.t())} | {:error, String.t()}
  def get_people(_, _, _) do
    {:ok, Repo.all(User)}
  end

  @spec login(any(), map, any()) :: {:ok, any()} | {:error, String.t()}
  def login(_, %{input: %{username: username, hash: hash}}, _) do
    with {:ok, %Profile{} = current_profile} <- Auth.authenticate(username, hash),
         {:ok, token, _claims} <- Guardian.encode_and_sign(current_profile) do
      {:ok, %{profile: current_profile, token: token}}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec sign_up(any(), map, any()) :: {:ok, any()} | {:error, String.t()}
  def sign_up(_, %{input: attrs}, _) do
    Accounts.create_user(attrs)
  end
end
