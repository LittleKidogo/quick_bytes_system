defmodule QbBackendWeb.Resolvers.AccountsTest do
  use QbBackendWeb.ApiCase

  alias QbBackendWeb.Resolvers.Accounts

  @num 5
  describe "Accounts Resolver" do
    test "fetches users on the system", %{conn: conn} do
      IO.puts("------ THE USERS --------")
      insert_list(@num, :user) |> IO.inspect()
      IO.puts("------ USERS END --------")
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

      IO.puts("------ THE RESULT ---------")
      IO.inspect(res)
      %{
        "data" => %{
          "users" => people
        }
      }
      = json_response(res, 200)

      IO.puts("--------- END OF RESULT -----------")

      assert Enum.count(people) == @num
    end
  end
end
