defmodule QbBackend.Utils.Schema do
  @moduledoc """
  This module defines the use macro for setting up schemas for the project
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @type t :: %__MODULE__{}

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end