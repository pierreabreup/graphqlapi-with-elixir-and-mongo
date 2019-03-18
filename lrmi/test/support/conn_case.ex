defmodule LrmiWeb.ConnCase do

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias LrmiWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint LrmiWeb.Endpoint
    end
  end

  setup do
    conn = Phoenix.ConnTest.build_conn()
        |> Plug.Conn.put_req_header("content-type", "application/json")

    {:ok, %{conn: conn}}
  end

end
