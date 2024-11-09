defmodule LedgerSystemWeb.TransactionsJSON do
  alias LedgerSystem.Transactions.Transaction

  def show(%{transaction: transaction}) do
    %{data: data(transaction)}
  end

  defp data(%Transaction{} = data) do
    %{
      id: data.id,
      amount: data.amount,
      type: data.type,
      inserted_at: data.inserted_at
    }
  end
end
