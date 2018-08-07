defmodule QbBackend.Accounts do
  @moduledoc """
  This is the boundary module for the Accounts Context
  We use this module to perform Accounts related actions
  """

  alias QbBackend.{
    Repo,
    Accounts.User,
    Accounts.Profile
  }

  @doc """
  This function takes a map os attrubutes and creates a user record with that
  map of attributes
  """
  @spec create_user(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  This function takes a user and a map of attributes it then proceeds to create
  a profile linked to the user with a reader role as default
  """
  @spec create_profile(User.t(), map()) :: {:ok, Profile.t()} | {:error, Ecto.Changeset.t()}
  def create_profile(%User{} = usr, attrs) do
    usr
    |> Profile.create_changeset(attrs)
    |> Repo.insert()
  end
end
