defmodule LedgerSystem.UpdateBalance.Worker do
  @moduledoc """
  This module is responsible for updating the account balance in the system.
  """
  use GenServer
  require Logger
  alias LedgerSystem.Accounts

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def start_task(payload) do
    GenServer.cast(__MODULE__, {:update_balance, payload})
  end

  def init(opts) do
    {:ok, opts}
  end

  def handle_cast({:update_balance, payload}, state) do
    Task.start(fn -> update_balance(payload) end)
    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp update_balance(%{"account_id" => account_id, "amount" => amount, "type" => type} = payload) do
    # Update the Account Balance to the repository
    Logger.info("Updating account balance with payload: #{inspect(payload)}")

    case Accounts.get_account!(account_id) do
      nil ->
        Logger.error("Account not found with id: #{account_id}")

      account ->
        new_balance =
          if type == "credit",
            do: Decimal.add(account.balance, Decimal.new(amount)),
            else: Decimal.sub(account.balance, Decimal.new(amount))

        account
        |> Accounts.update_account(%{"balance" => new_balance})
        |> case do
          {:ok, account} ->
            Logger.info("Updated account balance for account: #{account.id}")

            Phoenix.PubSub.broadcast(LedgerSystem.PubSub, "user:#{account.user_id}", %{
              "balance" => account.balance
            })

            Phoenix.PubSub.broadcast(LedgerSystem.PubSub, "balance_updated", %{
              "user_id" => account.user_id,
              "balance" => account.balance
            })

          {:error, changeset} ->
            Logger.error("#{inspect(changeset.errors)}")
            Logger.error("Failed to update account balance with payload #{inspect(payload)}")
        end
    end
  end
end
