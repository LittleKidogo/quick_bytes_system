defmodule QbBackendWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation

  alias QbBackendWeb.Resolvers

  # import types
  import_types(__MODULE__.AccountTypes)

  query do
    @desc "The list of available users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.get_people/3)
    end
  end

  mutation do
    @desc "user login"
    field :login, :session do
      arg :input, non_null(:session_input)
      resolve(&Resolvers.Accounts.login/3)
    end
  end
end
