defmodule LedgerSystem.AccountsTest do
  use LedgerSystem.DataCase

  alias LedgerSystem.Users
  alias LedgerSystem.Accounts

  def create_user_fixture do
    {:ok, user} =
      Users.create_user(%{
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

  describe "accounts" do
    test "create_account/1 creates an account" do
      account = create_account_fixture()
      assert account.balance == Decimal.new("100")
    end

    test "create_account/0 fails with empty attributes" do
      account = Accounts.create_account()
      assert {:error, %Ecto.Changeset{}} = account
    end

    test "get_account/1 returns the account with given id" do
      account = create_account_fixture()
      account_fetched = Accounts.get_account!(account.id)
      assert account_fetched.id == account.id
    end

    test "list_accounts/0 returns all accounts" do
      create_account_fixture()
      assert length(Accounts.list_accounts()) == 1
    end

    test "update_account/1 updates the account" do
      account = create_account_fixture()
      {:ok, updated_account} = Accounts.update_account(account, %{balance: 200})
      assert updated_account.balance == Decimal.new("200")
    end

    test "delete_account/1 deletes the account" do
      account = create_account_fixture()
      assert Accounts.delete_account(account)
      assert length(Accounts.list_accounts()) == 0
    end

    test "change_account/2" do
      account = create_account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
