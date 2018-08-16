defmodule QbBackendWeb.Schema.Middleware.Authorize do
  @moduledoc """
  This module contains middleware that runs before any
  resolvers thay need authentication
  """
  @behaviour Absinthe.Middleware

  @spec call(map(), list()) :: map()
  def call(resolution, roles) do
    with %{current_profile: profile} <- resolution.context,
         true <- correct_role?(profile, roles) do
      resolution
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unathorized"})
    end
  end

  @spec correct_role?(map(), list(String.t())) :: boolean()
  defp correct_role?(%{role: role}, roles), do: Enum.member?(roles, role)
  defp correct_role?(%{}, _), do: false
end
