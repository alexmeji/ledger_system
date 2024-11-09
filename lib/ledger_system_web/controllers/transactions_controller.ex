defmodule LedgerSystemWeb.TransactionsController do
  use Phoenix.Controller, formats: [:json]
  alias LedgerSystem.Users
  alias LedgerSystem.Transactions
  alias LedgerSystem.Transactions.Transaction
  alias LedgerSystem.Accounts

  def debit(conn, %{"user_id" => user_id, "amount" => amount}) do
    with {:ok, %Transaction{} = transaction} <-
           create_transaction_and_update_balance(user_id, amount, "debit") do
      conn
      |> put_status(:created)
      |> render(:show, transaction: transaction)
    end
  end

  def credit(conn, %{"user_id" => user_id, "amount" => amount}) do
    with {:ok, %Transaction{} = transaction} <-
           create_transaction_and_update_balance(user_id, amount, "credit") do
      conn
      |> put_status(:created)
      |> render(:show, transaction: transaction)
    end
  end

  defp create_transaction_and_update_balance(user_id, amount, type) do
    with user <- Users.get_user!(user_id),
         account <- Accounts.get_user_account!(user.id),
         {:ok, %Transaction{} = transaction} <-
           Transactions.create_transaction(%{
             "user_id" => user_id,
             "amount" => amount,
             "type" => type
           }) do
      LedgerSystem.UpdateBalance.Worker.start_task(%{
        "account_id" => account.id,
        "amount" => :erlang.float_to_binary(amount, decimals: 2),
        "type" => type
      })

      {:ok, transaction}
    end
  end
end
