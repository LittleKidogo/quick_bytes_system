defmodule QbBackendWeb.Schema.PostTypes do
  @moduledoc """
  This module contains GraphQL types used with
  the accounts context.
  """
  use Absinthe.Schema.Notation
  alias QbBackendWeb.{
    Schema.Middleware,
    Resolvers.Posts
  }

  @desc "posts mutations"
  object :posts_mutations do
    @desc "create a manual"
    field :add_manual, :manual do
      arg(:input, non_null(:add_manual_input))
      middleware Middleware.Authorize, ["publisher", "author"]
      resolve(&Posts.add_manual/3)
    end
  end

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
  end
end
