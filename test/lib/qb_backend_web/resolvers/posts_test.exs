defmodule QbBackendWeb.Resolvers.PostsTest do
  use QbBackendWeb.ApiCase

  @manual_attrs %{body: "some body", title: "some title"}
  @body "this is a body"
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

  @tag authenticated: "reader"
  test " add a comment on a manual ", %{conn: conn} do
    manual = insert(:manual)

    variables = %{
      "input" => %{
        "body" => @body,
        "manual_id" => manual.id
      }
    }

    query = """
    mutation ($input: AddCommentInput!) {
            addComment(input: $input) {
              body
            }
          }
    """

    res = post(conn, "api/graphiql", query: query, variables: variables)


    %{
      "data" => %{
        "addComment" => comment
      }
    } = json_response(res, 200)

    assert comment["body"] == @body
  end

  test " add a comment errors out when users is not signed in ", %{conn: conn} do
    manual = insert(:manual)

    variables = %{
      "input" => %{
        "body" => @body,
        "manual_id" => manual.id
      }
    }

    query = """
    mutation ($input: AddCommentInput!) {
            addComment(input: $input) {
              body
            }
          }
    """

    res = post(conn, "api/graphiql", query: query, variables: variables)


    %{
      "errors" => [error]
    } = json_response(res, 200)

    assert error["message"] == "unauthorized"
  end
end
