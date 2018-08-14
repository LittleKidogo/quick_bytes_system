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
  This function takes the id of a user and proceeds to find the associated account
  """
  @spec get_user(String.t()) :: {:ok, User.t()} | {:error, String.t()}
  def get_user(id) do
    with %User{} = usr <- Repo.get_by(User, id: id) do
      {:ok, usr}
    else
      nil -> {:error, "No user with id #{id} on the system"}
    end
  end

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
  This function takes a user and deletes that user from the database
  """
  @spec delete_user(User.t()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def delete_user(%User{} = usr) do
    usr |> Repo.delete()
  end

  @doc """
  This functiaon takes a user and a map of update attributes that it uses
  to update the user in question's details
  """
  @spec update_user(User.t(), map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def update_user(%User{} = usr, attrs) do
    usr
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  This function takes a user and a map of attributes it then proceeds to create
  a profile linked to the user with a reader role as default
  """
  @spec create_profile(User.t(), map()) :: {:ok, Profile.t()} | {:error, String.t()}
  def create_profile(%User{} = usr, attrs) do
    usr
    |> Profile.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  This function takes a profile and a map attributes then proceeds to update that
  profile wit the maps
  """
  @spec update_profile(Profile.t(), map) :: {:ok, Profile.t()} | {:error, Ecto.Changeset.t()}
  def update_profile(%Profile{} = prf, attrs) do
    prf
    |> Profile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  This function takes a profile and proceeds to delete that profile from the
  application database
  """
  @spec delete_profile(Profile.t()) :: {:ok, Profile.t()} | {:error, Ecto.Changeset.t()}
  def delete_profile(%Profile{} = prf) do
    prf |> Repo.delete()
  end

  @doc """
  This function takes a profile id and fetches a profile if one exists with the id, it returns an error
  if one does not exist
  """
  @spec get_profile(String.t()) :: {:ok, Profile.t()} | {:error, String.t()}
  def get_profile(id) do
    with %Profile{} = prof <- Repo.get_by(Profile, id: id) do
      {:ok, prof}
    else
      nil -> {:error, "No Profile with id #{id} on the system"}
    end
  end
end
