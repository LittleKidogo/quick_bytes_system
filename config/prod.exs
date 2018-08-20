use Mix.Config
# Confiure application
config :qb_backend, QbBackendWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "${HOST}", port: "${PORT}"],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true, # automatically serve the application when it staterts
  root: ".", # use this as the server root
  version: Application.spec(:qb_backend, :vsn)



# Do not print debug messages in production
config :logger, level: :info


# Configure your database
config :qb_backend, QbBackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: "${DB_HOSTNAME}",
  username: "${DB_USERNAME}",
  password: "${DB_PASSWORD}",
  database: "${DB_NAME}",
  port: "${DB_PORT}",
  pool_size: 15
