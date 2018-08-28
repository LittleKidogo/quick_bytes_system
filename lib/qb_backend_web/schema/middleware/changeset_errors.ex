defmodule QbBackendWeb.Schema.Middleware.ChangesetErrors do
  @moduledoc """
  This module contains helper functions for formatting changeset errors into
  a nice response for our resolvers
  """
  @behaviour Absinthe.Middleware

  @doc """
  This fuction takes an Absinthe resolution and checkes it for Changeset Errors
  If it finds errors it formats them into a helpful fashion
  """
  @spec call(map(), any()) :: map()
  def call(res, _) do
    %{res | errors: Enum.flat_map(res.errors, &transform_error/1)}
  end

  @spec transform_error(Ecto.Changeset.t()) :: String.t()
  defp transform_error(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&build_error/1)
    |> Enum.map(fn {item, error} -> "#{item}: #{error}" end)
  end

  # handle other kinds of errors
  defp transform_error(error), do: [error]
  
  # build error using options
  @spec build_error(tuple()) :: String.t()
  defp build_error({msg, opts}) do
    Enum.reduce(opts, msg, fn({key, value}, acc) ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end 
end
