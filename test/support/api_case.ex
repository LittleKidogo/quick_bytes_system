defmodule QbBackendWeb.ApiCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's GraphQL API layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  use Phoenix.ConnTest
  import QbBackend.Factory

  using do
    quote do
      use Phoenix.ConnTest
      alias QbBackend.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import QbBackend.DataCase
      import QbBackend.Factory

      # The default endpoint for testing
      @endpoint QbBackendWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(QbBackend.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(QbBackend.Repo, {:shared, self()})
    end

    # get the current profile using a tag
    # it the test has the authenticated tag the conn is given a profile to auth
    # with this should be extended to allow types of profiles

    # credo:disable-for-lines:10
    {conn, current_profile} =
      cond do
        tags[:authenticated] ->
          build_conn()
          |> add_auth_header(tags[:authenticated])

        true ->
          conn = build_conn()
          {conn, nil}
      end

    {:ok, conn: conn, current_profile: current_profile}
  end

  defp add_auth_header(conn, true) do
    profile = insert(:profile)

    conn |> QbBackend.AuthenticationTestHelpers.authenticate(profile)
  end
end
