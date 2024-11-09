defmodule LedgerSystem.TransactionsTest do
  use LedgerSystem.DataCase

  alias LedgerSystem.Users
  alias LedgerSystem.Accounts
  alias LedgerSystem.Transactions

  def create_user_fixture do
    {:ok, user} = Users.create_user(%{
        name: "Alex",
        email: "me@me.com",
        password: "password"
      })

    user
  end

  def create_account_fixture do
    user = create_user_fixture()

    {:ok, account} =
      Accounts.create_account(%{
        user_id: user.id,
        balance: 100
      })

    account
  end

  describe "transactions" do
    test "create_transaction/1 creates a transaction" do
      account = create_account_fixture()
      {:ok, transaction} = Transactions.create_transaction(%{
          account_id: account.id,
          type: "debit",
          amount: 50
        })

      assert transaction.amount == Decimal.new("50")
    end

    test "create_transaction/0 fails with empty attributes" do
      transaction = Transactions.create_transaction()
      assert {:error, %Ecto.Changeset{}} = transaction
    end

    test "get_transaction/1 returns the transaction with given id" do
      account = create_account_fixture()
      {:ok, transaction} = Transactions.create_transaction(%{
          account_id: account.id,
          type: "debit",
          amount: 50
        })

      transaction_fetched = Transactions.get_transaction!(transaction.id)
      assert transaction_fetched.id == transaction.id
    end

    test "list_transactions/0 returns all transactions" do
      account = create_account_fixture()
      {:ok, _} = Transactions.create_transaction(%{
          account_id: account.id,
          type: "debit",
          amount: 50
        })

      assert length(Transactions.list_transactions()) == 1
    end

    test "update_transaction/1 updates the transaction" do
      account = create_account_fixture()
      {:ok, transaction} = Transactions.create_transaction(%{
          account_id: account.id,
          type: "debit",
          amount: 50
        })

      {:ok, updated_transaction} = Transactions.update_transaction(transaction, %{amount: 100})
      assert updated_transaction.amount == Decimal.new("100")
    end

    test "delete_transaction/1 deletes the transaction" do
      account = create_account_fixture()
      {:ok, transaction} = Transactions.create_transaction(%{
          account_id: account.id,
          type: "debit",
          amount: 50
        })

      assert Transactions.delete_transaction(transaction)
      assert length(Transactions.list_transactions()) == 0
    end

    test "change_transaction/2" do
      account = create_account_fixture()
      {:ok, transaction} = Transactions.create_transaction(%{
          account_id: account.id,
          type: "debit",
          amount: 50
        })

      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
