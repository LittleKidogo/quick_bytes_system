defmodule QbBackendWeb.Schema do
  use Absinthe.Schema

  alias QbBackendWeb.Resolvers

  # import types
  import_types(__MODULE__.AccountTypes)
  import_types(__MODULE__.PostTypes)

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
