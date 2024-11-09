defmodule LedgerSystem.Repo do
  use Ecto.Repo,
    otp_app: :ledger_system,
    adapter: Ecto.Adapters.Postgres
end
