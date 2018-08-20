defmodule QbBackendWeb.ApiCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection working
  on the GraphQL API endpoints

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  import QbBackend.Factory
  use Phoenix.ConnTest

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import QbBackendWeb.Router.Helpers
      alias QbBackend.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import QbBackend.Factory

      # The default endpoint for testing
      @endpoint QbBackendWeb.Endpoint
    end
  end

  setup context do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(QbBackend.Repo)

    unless context[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(QbBackend.Repo, {:shared, self()})
    end

    {conn, profile} =
      # credo:disable-for-next-line
      cond do
        context[:authenticated] ->
          build_conn()
          |> add_authentication_headers(context[:authenticated])

        true ->
          conn = build_conn()
          {conn, nil}
      end

    {:ok, conn: conn, current_profile: profile}
  end

  # add information to connection
  @spec add_authentication_headers(Plug.Conn.t(), String.t()) :: {Plug.Conn.t(), any()}
  defp add_authentication_headers(conn, role) do
    profile = insert(:profile, role: role)

    conn = conn |> QbBackend.AuthenticationTestHelpers.authenticate(profile)

    {conn, profile}
  end
end
