defmodule LedgerSystemWeb.TransactionsTest do
  use LedgerSystemWeb.ConnCase

  @create_attrs %{name: "Alex", email: "me@me.com", password: "admin"}

  describe "transactions_controller" do
    test "POST /credit", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @create_attrs)
      %{"id" => id} = json_response(conn, 201)["data"]

      conn = post(conn, ~p"/api/credit", %{user_id: id, amount: 100.00})
      Process.sleep(1000)
      assert json_response(conn, 201)["data"]["amount"] == "100.0"

      conn = get(conn, ~p"/api/balance/#{id}")
      accounts = json_response(conn, 200)["data"]["accounts"]
      assert Enum.at(accounts, 0)["balance"] == "100.00"
    end

    test "POST /debit", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @create_attrs)
      %{"id" => id} = json_response(conn, 201)["data"]

      conn = post(conn, ~p"/api/credit", %{user_id: id, amount: 100.00})
      Process.sleep(1000)
      assert json_response(conn, 201)["data"]["amount"] == "100.0"

      conn = post(conn, ~p"/api/debit", %{user_id: id, amount: 50.00})
      Process.sleep(1000)
      assert json_response(conn, 201)["data"]["amount"] == "50.0"

      conn = get(conn, ~p"/api/balance/#{id}")
      accounts = json_response(conn, 200)["data"]["accounts"]
      assert Enum.at(accounts, 0)["balance"] == "50.00"
    end
  end
end
