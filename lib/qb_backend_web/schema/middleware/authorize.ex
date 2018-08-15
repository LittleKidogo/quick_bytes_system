defmodule QbBackendWeb.Schema.Middleware.Authorize do
  @moduledoc """
  This module contains middleware that runs before any
  resolvers thay need authentication
  """
  @behaviour Absinthe.Middleware

  @spec call(map(), map()) :: map()
  def call(resolution, roles) do
    with %{current_profile: profile} <- resolution.context,
         true <- correct_role?(profile, role) do
      resolution
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unathorized"})
    end
  end

  defp correct_role?(%{role: role}, roles), do: Enum.member(roles, role)
  defp correct_role?(%{}, _), do: false
end

