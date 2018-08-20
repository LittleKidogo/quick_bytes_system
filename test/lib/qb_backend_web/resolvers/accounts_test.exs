defmodule QbBackendWeb.Resolvers.AccountsTest do
  use QbBackendWeb.ApiCase

  alias QbBackend.{
    Accounts.User,
    Accounts.Profile
  }

  @num 5
  describe "Accounts Resolver" do
    test "logs a user on to system", %{conn: conn} do
      {:ok, user} = %User{} |> User.changeset(%{name: "zacck", hash: "12345"}) |> Repo.insert()
      profile = insert(:profile, user: user)

      assert Repo.aggregate(User, :count, :id) == 1
      assert Repo.aggregate(Profile, :count, :id) == 1

      variables = %{
        "input" => %{
          "hash" => "12345",
          "username" => profile.username
        }
      }

      query = """
      mutation($input: SessionInput!) {
        login(input: $input){
          token
          profile {
            role
            username
          }
        }
      }
      """

      res = post(conn, "api/graphiql", query: query, variables: variables)

      %{
        "data" => %{
          "login" => result
        }
      } = json_response(res, 200)

      assert result["token"]
      assert result["profile"]["role"] == profile.role
      assert result["profile"]["username"] == profile.username
    end

    test "fetches users on the system", %{conn: conn} do
      insert_list(@num, :user)
      assert Repo.aggregate(User, :count, :id) == @num

      query = """
      query {
        Users{
          name
          id
        }
      }
      """

      res = post(conn, "api/graphiql", query: query)

      %{
        "data" => %{
          "Users" => people
        }
      } = json_response(res, 200)

      assert Enum.count(people) == @num
    end

    test "adds a user to system", %{conn: conn} do
      assert Repo.aggregate(User, :count, :id) == 0

      variables = %{
        "input" => %{
          "hash" => "$2b$12$yPihwzdz/4XPRd3bK2WC9eCCpBeCDU32e7cxtqEDpqOpQ/AsdBFrC",
          "name" => "Zacck Osiemo"
        }
      }

      query = """
        mutation($input: SignUpInput!){
          signUp(input: $input){
            name
          }
        }
      """

      res = post(conn, "api/graphiql", query: query, variables: variables)

      %{
        "data" => %{
          "signUp" => user
        }
      } = json_response(res, 200)

      assert Repo.aggregate(User, :count, :id) == 1
      assert user["name"] == variables["input"]["name"]
    end
  end
end
