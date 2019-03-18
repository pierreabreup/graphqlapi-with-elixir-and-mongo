defmodule LrmiGraphql.Queries.CreativeWorksTest do
  use Lrmi.DataCase
  use LrmiWeb.ConnCase

  alias Lrmi.Resources
  alias LrmiGraphql.AbsintheHelpers

  describe "Queries.CreativeWorks" do

    def create_creative_work(attrs \\ %{}) do
      build(:creative_work, attrs)
      |> Resources.create_creative_work()
    end

    def graphql_request_creative_works(connection, query) do
      connection.conn
      |> post("/", AbsintheHelpers.query_skeleton(query, "creativeWorks"))
    end

    test "show error message when 'first' is out of range", connection do
      query = """
      {
        creativeWorks(first: 2000) {
          edges{
            node {
              name
            }
          }
        }
      }
      """

      res = graphql_request_creative_works(connection, query)
      assert hd(json_response(res, 200)["errors"])["message"] == "The first/last argument must be lower or equal than 1000"
    end

    test "show error message when 'last' is out of range", connection do
      query = """
      {
        creativeWorks(first: 2000) {
          edges{
            node {
              name
            }
          }
        }
      }
      """

      res = graphql_request_creative_works(connection, query)
      assert hd(json_response(res, 200)["errors"])["message"] == "The first/last argument must be lower or equal than 1000"
    end

    test "show error message when there is no 'first' and 'last' arguments", connection do
      query = """
      {
        creativeWorks {
          edges{
            node {
              name
            }
          }
        }
      }
      """

      res = graphql_request_creative_works(connection, query)
      assert hd(json_response(res, 200)["errors"])["message"] == "The argument \"first\" or the argument \"last\" must be present"
    end

    test "show 'first:1' content", connection do
      {_, content} = create_creative_work()
      create_creative_work()

      query = """
      {
        creativeWorks(first: 1) {
          edges{
            node {
              name
            }
          }
        }
      }
      """

      res = graphql_request_creative_works(connection, query)
      first_content = hd(json_response(res, 200)["data"]["creativeWorks"]["edges"])

      assert length(json_response(res, 200)["data"]["creativeWorks"]["edges"]) == 1 && first_content["node"]["name"] == content.name
    end

    test "show 'last:1' content", connection do
      create_creative_work()
      {_, content} = create_creative_work()


      query = """
      {
        creativeWorks(last: 1) {
          edges{
            node {
              name
            }
          }
        }
      }
      """

      res = graphql_request_creative_works(connection, query)

      last_content = hd(json_response(res, 200)["data"]["creativeWorks"]["edges"])

      assert length(json_response(res, 200)["data"]["creativeWorks"]["edges"]) == 1 && last_content["node"]["name"] == content.name
    end

    test "cursor is a String of size 24", connection do
      create_creative_work()

      query = """
      {
        creativeWorks(last: 1) {
          edges{
            cursor
          }
        }
      }
      """

      res = graphql_request_creative_works(connection, query)
      assert String.length(hd(json_response(res, 200)["data"]["creativeWorks"]["edges"])["cursor"]) == 24

    end

  end
end
