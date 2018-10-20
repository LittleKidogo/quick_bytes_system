# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :qb_backend,
  ecto_repos: [QbBackend.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :qb_backend, QbBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SPz+WgfQgVeR++lV7mXZo8OMCr89njV2rsMhKycq5ENJRX2c25X+a5HdVDln2P3A",
  render_errors: [view: QbBackendWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: QbBackend.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# # Configure Guardian
config :qb_backend, QbBackend.Auth.Guardian,
  issuer: "qb_backend",
  secret_key: "tPuIAA500x8K8lUP0rVol016NgT5wif2ELW3vijQUESfvhNfw1tIKpYLe7mSknEm"

# Configure ex_aws
config :ex_aws,
  access_key_id: ["AKIA5QEQH7C7JAAM2F3W", :instance_role],
  secret_access_key: ["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", :instance_role],
  s3: [
    scheme: "https://",
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
