import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ledger_system, :env, :test

config :ledger_system, LedgerSystem.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ledgerdev_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ledger_system, LedgerSystemWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LSz8TK7KwgLSperomOC2PogqsZwx1lc8qOcH6qf46TMsSSHmMBbJ0s7WFQJYgFF6",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
