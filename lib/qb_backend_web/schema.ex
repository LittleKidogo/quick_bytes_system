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
  def middleware(middleware, %{identifier: _fid} = field, _object) do
    meta = Absinthe.Type.meta(field, :auth)

    case meta do
      nil ->
        middleware

      meta ->
        [{{Middleware.Authorize, :call}, meta} | middleware]
    end
  end

  # Add middleware to fields that need it
  def middleware(middleware, _, %{identifier: :mutation}) do
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
