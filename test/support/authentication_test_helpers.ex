
defmodule QbBackend.AuthenticationTestHelpers do
  use Phoenix.ConnTest
  import QbBackend.Factory

  @doc """
  when given a connection to authenticate create a user call auth with the user
  and add a token in the request header just a client would do when calling the
  API
  """
  def authenticate(conn) do
    profile = insert(:profile)
    conn
    |> authenticate(profile)
  end


  @doc """
  when given a connection to authenticate with a user create a jwt token for the
  user and attacj it as a request header to the connection
  """
  def authenticate(conn, profile) do
    # get the token for the user
    {:ok, token, _} = profile |> QbBackendU.Auth.Guardian.encode_and_sign()

    # add the users token to the request header
    conn
    |> put_req_header("authorization", "Bearer #{token}")
  end
end
