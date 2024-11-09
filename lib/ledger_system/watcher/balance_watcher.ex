defmodule LedgerSystem.Watcher.BalanceWatcher do
  @moduledoc """
  This module is responsible for watching the balance updates in the system.
  """
  require Logger
  use GenServer

  @name {:global, __MODULE__}
  @topic "balance_updated"

  def start_link(_) do
    case GenServer.start_link(__MODULE__, nil, name: @name) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, _pid}} -> :ignore
      {:error, _} = err -> err
    end
  end

  @impl true
  def init(_) do
    {:ok, {Phoenix.PubSub.subscribe(LedgerSystem.PubSub, @topic)}}
    Logger.info("Subscribed to #{@topic}")

    {:ok, %{}}
  end

  @impl true
  def handle_info(%{"balance" => balance, "user_id" => user_id}, state) do
    # IO.puts("Received message: #{inspect(message)}")
    Logger.info("Received balance update: #{balance} for user: #{user_id}")
    {:noreply, state}
  end

  def handle_info(_, state) do
    Logger.info("Received unknown message")
    {:noreply, state}
  end
end
