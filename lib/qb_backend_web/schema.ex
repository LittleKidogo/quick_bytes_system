defmodule QbBackendWeb.Schema do
  @moduledoc """
  This module holds the GraphQL Schema for the Little Kidogo How To Domain
  """
  use Absinthe.Schema

  alias QbBackendWeb.{
    Schema.Middleware
  }

  # import types
  import_types(__MODULE__.AccountTypes)
  import_types(__MODULE__.PostTypes)

  # Add middleware to fields that need it
  def middleware(middleware, %{identifier: field_id}, %{identifier: :mutation}) do
    # authorization middleware
    type = Absinthe.Schema.lookup_type(__MODULE__, :mutation)
    auth_meta = Absinthe.Type.meta(type, :auth)
    IO.puts("------ Allowed for #{field_id} -----------")
    IO.inspect(auth_meta)
    IO.puts("---------- END Allowed list -----------")
    [{{Authorize, :call}, [auth_meta]} | middleware]
    # end authorization

    middleware ++ [Middleware.ChangesetErrors]
  end

  def middleware(middleware, _, _) do
    middleware
  end

  query do
    import_fields(:account_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:posts_mutations)
  end
end
