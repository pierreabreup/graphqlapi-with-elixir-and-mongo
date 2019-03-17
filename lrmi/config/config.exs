# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lrmi,
  ecto_repos: [Lrmi.Repo]

# Configures the endpoint
config :lrmi, LrmiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "k1x30yIssIIOD+gV18sN4WqKiPGQ+kYQE4mygmQ4j3X/UIBIOZn+GxD9HWAEXA4R",
  render_errors: [view: LrmiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Lrmi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :absinthe, adapter: Absinthe.Adapter.LanguageConventions

config :lrmi, :data_pagination,
  limit: 1000

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
