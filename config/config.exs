# config/config.exs

use Mix.Config

config :ledger,
  ecto_repos: [Ledger.Repo]

config :ledger, Ledger.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ledger_dev",
  hostname: "localhost",
  pool_size: 10

config :ledger, LedgerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YOUR_SECRET_KEY_BASE",
  render_errors: [view: LedgerWeb.ErrorView, accepts: ~w(json)],
  pubsub_server: Ledger.PubSub,
  live_view: [signing_salt: "YOUR_SIGNING_SALT"]

# Use Phoenix LiveView with the HTML over-the-wire format
config :phoenix, :stacktrace_depth, 20

config :phoenix, :format_encoders,
  "text/html": Phoenix.Template.EExEngine

config :mime, :types, %{
  "text/html" => ["html", "htm", "xhtml", "jhtml"]
}

# Configures Ecto
config :ledger, Ledger.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ledger_dev",
  hostname: "localhost",
  pool_size: 10

# Configures Phoenix endpoint
config :ledger, LedgerWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [],
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*.po$",
      ~r"lib/ledger_web/{live,views}/.*.ex",
      ~r"lib/ledger_web/controllers/.*.ex",
      ~r"lib/ledger_web/templates/.*"
    ]
  ]

config :ledger, :pow,
  user: Ledger.Users.User,
  repo: Ledger.Repo

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  eex: LedgerWeb.EExEngine