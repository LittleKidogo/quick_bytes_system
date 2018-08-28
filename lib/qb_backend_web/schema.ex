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


  # Apply middleware to field depending on meta keys
  def middleware(middleware, %{identifier: _fid} = field, %{identifier: oid}) do
    middleware = 
    case oid do 
      :mutation ->
         middleware ++ [Middleware.ChangesetErrors]

      _ -> middleware
    end 
    
    meta = Absinthe.Type.meta(field, :auth)

    case meta do
      nil ->
        middleware
    
      meta ->
        [{{Middleware.Authorize, :call}, meta} | middleware]
    end
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
