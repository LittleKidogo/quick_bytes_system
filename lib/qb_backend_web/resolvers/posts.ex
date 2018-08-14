defmodule QbBackendWeb.Resolvers.Posts do
  @moduledoc """
  A Module to hand web facing interactions for the posts context
  """
  alias QbBackend.{
    Accounts,
    Accounts.Profile,
    Posts,
    Posts.Manual
  }

  @spec add_manual(any(), map(), any()) :: {:ok, Manual.t()} | {:error, String.t()}
  def add_manual(_, %{input: params}, _) do
    with {:ok, %Profile{} = profile} <- Accounts.get_profile(params.profile_id),
         {:ok, %Manual{} = mnl} <- Posts.create_manual(profile, params) do
      {:ok, mnl}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
