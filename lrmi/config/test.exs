use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lrmi, LrmiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :lrmi, :db_config,
  name: :mongo,
  database: "lrmi_test",
  seeds: ["mongodb:27017"],
  pool: DBConnection.Poolboy
