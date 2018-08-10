defmodule QbBackend.Posts do
  @moduledoc """
  This module takes the id of a manual and proceeds to find the associated Manual
  """

  alias QbBackend.{
      Repo,
      Posts.Manual,
      Posts.Comment,
      Accounts.Profile
    }

  @doc """
   This function takes the manual identification and proceeds to find the associated manual
  """
  @spec get_manual(String.t()) :: {:ok, Manual.t()} | {:error, String.t()}
  def get_manual(id) do
    with %Manual{} = manual <- Repo.get_by(Manual, id: id) do
      {:ok, manual}
    else
      nil -> {:error, "No Manual with id: #{id} on the system"}
    end
  end

  @doc """
    This function takes the map attributes and saves a manual record with that map of attributes
  """
  @spec create_manual(Profile.t(), map()) :: {:ok, Manual.t()} | {:error, Ecto.Changeset.t()}
  def create_manual(%Profile{} = prof, attrs) do
    prof
    |> Manual.create_changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  This function takes a manual and a map of update attributes that it uses to
  update the manual
  """
  @spec update_manual(Manual.t(), map()) :: {:ok, Manual.t()} | {:error, Ecto.Changeset.t()}
  def update_manual(%Manual{} = manual, attrs) do
    manual
    |> Manual.changeset(attrs)
    |> Repo.update()
  end

  #Comments related functions

  @doc """
  this function takes a Manual struct and map as parameters and creates a comment
  linked to the specified Manual.
  """
  @spec add_comment(Profile.t(), Manual.t(),  map()) :: {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def add_comment(%Profile{} = profile, %Manual{} = manual, params) do
    profile
    |> Comment.create_changeset(manual, params)
    |> Repo.insert()
  end

  @doc """
  this function takes a Comment stratcure and a map as params and updates the comment
  """
  @spec edit_comment(Comment.t(), map()) :: {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def edit_comment(%Comment{} = comment, params) do
    comment
    |> Comment.changeset(params)
    |> Repo.update()
  end

  @doc """
  this function takes a comment structure and deletes its
  """
  @spec delete_comment(Comment.t()) :: {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def delete_comment(%Comment{} = comment) do
    comment
    |> Repo.delete()
  end
end
