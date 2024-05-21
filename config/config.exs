# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :elixir_project,
  ecto_repos: [ElixirProject.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :elixir_project, ElixirProjectWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: ElixirProjectWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ElixirProject.PubSub,
  live_view: [signing_salt: "bzTy/ajH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :elixir_project, ElixirProjectWeb.Auth.Guardian,
  issuer: "elixir_project",
  secret_key: "ieWbwrRolXfMA3AJGenASNLcqilCmhCNMVLbI/LVepOw7qlerVbQqMVNnnE1yCtA"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
