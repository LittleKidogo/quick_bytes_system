defmodule QbBackendWeb.Resolvers.Posts do
  @moduledoc """
  A Module to hand web facing interactions for the posts context
  """
  alias QbBackend.{
    Posts,
    Posts.Manual
  }

  @spec add_manual(any(), map(), any()) :: {:ok, Manual.t()} | {:error, String.t()}
  def add_manual(_, %{input: params}, %{context: %{current_profile: profile}}) do
    with {:ok, %Manual{} = mnl} <- Posts.create_manual(profile, params) do
      {:ok, mnl}
    end
  end
end
