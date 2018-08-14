defmodule QbBackendWeb.Router do
  use QbBackendWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", QbBackendWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug, schema: QbBackendWeb.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: QbBackendWeb.Schema, interface: :playground)
  end
end
