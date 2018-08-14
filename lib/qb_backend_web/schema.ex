defmodule QbBackendWeb.Schema do
  @moduledoc """
  This module holds the GraphQL Schema for the Little Kidogo How To Domain
  """
  use Absinthe.Schema

  alias QbBackendWeb.{
    Resolvers,
    Schema.Middleware
  }



  # import types
  import_types(__MODULE__.AccountTypes)
  import_types(__MODULE__.PostTypes)


  # Add middleware to fields that need it
  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  def middleware(middleware, _, _) do
    middleware
  end

  query do
    @desc "The list of available users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.get_people/3)
    end
  end

  mutation do
    @desc "user login"
    field :login, :session do
      arg(:input, non_null(:session_input))
      resolve(&Resolvers.Accounts.login/3)
    end

    @desc "create a manual"
    field :add_manual, :manual do
      arg(:input, non_null(:add_manual_input))
      resolve(&Resolvers.Posts.add_manual/3)
    end
  end
end
