defmodule LedgerSystemWeb.UsersControllerTest do
  use LedgerSystemWeb.ConnCase, async: true

  @create_attrs %{name: "Alex", email: "me@me.com", password: "admin"}

  describe "users_controller" do
    test "GET /users", %{conn: conn} do
      conn = get(conn, ~p"/api/users")
      assert json_response(conn, 200)["data"] == []
    end

    test "POST /users", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/balance/#{id}")

      assert %{
               "id" => ^id,
               "name" => "Alex"
             } = json_response(conn, 200)["data"]

      accounts = json_response(conn, 200)["data"]["accounts"]
      assert Enum.count(accounts) == 1
    end

    test "POST /users with invalid data", %{conn: conn} do
      assert_raise Plug.BadRequestError, fn ->
        post(conn, ~p"/api/users", %{name: "Alex", email: "", password: "admin"})
      end
    end

    test "GET /balance/id", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @create_attrs)
      %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/balance/#{id}")

      accounts = json_response(conn, 200)["data"]["accounts"]
      assert Enum.at(accounts, 0)["balance"] == "0"
    end
  end
end
