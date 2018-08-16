defmodule QbBackendWeb.Resolvers.Posts do
  @moduledoc """
  A Module to handle web facing interactions for the posts context
  """
  alias QbBackend.{
    Posts,
    Posts.Manual
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
end
