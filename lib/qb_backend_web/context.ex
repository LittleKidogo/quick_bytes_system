defmodule QbBackendWeb.Context do
  @moduledoc """
  This module is a plug that we use to populate the execution context for requests
  """
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, profile, _} = QbBackend.Auth.Guardian.resource_from_token(token) do
      %{current_profile: profile}
    else
      _ -> %{}
    end
  end
end
