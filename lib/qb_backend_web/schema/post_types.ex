defmodule QbBackendWeb.Schema.PostTypes do
  @moduledoc """
  This module contains GraphQL types used with
  the accounts context.
  """
  use Absinthe.Schema.Notation

  @desc "manual type"
  object :manual do
    field(:title, :string)
    field(:body, :string)
    field(:id, :id)
  end

  @desc "input to create a manual on the system"
  input_object :add_manual_input do
    field(:title, non_null(:string))
    field(:body, non_null(:string))
    field(:profile_id, non_null(:id))
  end
end
