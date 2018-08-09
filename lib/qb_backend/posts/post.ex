defmodule QbBackend.Posts do
  @moduledoc """
  This module defines the actions related to the
  handling of items within the Posts boundary
  """
  alias QbBackend.{
    Accounts.Profile,
    Posts.Comment,
    Repo
  }

  #Comments related functions

  @doc """
  this function takes a Manual struct and map as parameters and creates a comment
  linked to the specified Manual.
  """
  @spec add_comment(Profile.t(), map()) :: {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def add_comment(%Profile{} = post, params) do
    %Comment{}
    |> Comment.create_changeset(params)
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
