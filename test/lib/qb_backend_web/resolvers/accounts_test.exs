defmodule QbBackendWeb.Resolvers.AccountsTest do
  use QbBackendWeb.ApiCase

  alias QbBackend.Accounts.User

  @num 5
  describe "Accounts Resolver" do
    test "fetches users on the system", %{conn: conn} do
      insert_list(@num, :user)
      assert Repo.aggregate(User, :count, :id) == @num

      query = """
      query {
        users{
          name
          id
        }
      }
      """

      res = post(conn, "api/graphiql", query: query)

      %{
        "data" => %{
          "users" => people
        }
      }
      = json_response(res, 200)


      assert Enum.count(people) == @num
    end
  end
end
