defmodule QbBackendWeb.Resolvers.PostsTest do
  use QbBackendWeb.ApiCase

  @manual_attrs %{body: "some body", title: "some title"}
  describe "Posts Resolver" do
    @tag authenticated: "publisher"
    test "add_manual adds a manual on the system if a user is a publisher", %{conn: conn} do
      variables = %{
        "input" => %{
          "title" => @manual_attrs.title,
          "body" => @manual_attrs.body
        }
      }

      query = """
      mutation ($input: AddManualInput!) {
        addManual(input: $input) {
          body
          title
        }
      }
      """

      res = post(conn, "api/graphiql", query: query, variables: variables)

      %{
        "data" => %{
          "addManual" => manual
        }
      } = json_response(res, 200)

      assert manual["body"] == @manual_attrs.body
      assert manual["title"] == @manual_attrs.title
    end
  end
end
