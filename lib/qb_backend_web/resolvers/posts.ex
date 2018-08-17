defmodule QbBackendWeb.Resolvers.Posts do
  @moduledoc """
  A Module to handle web facing interactions for the posts context
  """
  alias QbBackend.{
    Posts,
    Posts.Manual,
    Posts.Comment,
    Accounts.Profile,
    Accounts
  }

  @doc """
  This function creates a manual using the input params given and the signed
  in profile in the context
  """
  @spec add_manual(any(), map(), any()) :: {:ok, Manual.t()} | {:error, String.t()}
  def add_manual(_, %{input: params}, %{context: %{current_profile: profile}}) do
    with {:ok, %Manual{} = mnl} <- Posts.create_manual(profile, params) do
      {:ok, mnl}
    end
  end

  @doc """
  This function adds a comment to a manual
  """
  @spec add_comment(any(), map(), any()) :: {:ok, Comment.t()} | {:error, String.t()}
  def add_comment(_, %{input: attr}, %{context: %{current_profile: profile}}) do
    with {:ok, %Manual{} = manual} <- Posts.get_manual(attr.manual_id),
         {:ok, %Comment{} = comment} <- Posts.add_comment(profile, manual, attr) do
      {:ok, comment}
    end
  end
end
