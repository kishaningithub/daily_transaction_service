# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :daily_transaction_service,
  ecto_repos: [DailyTransactionService.Repo]

# Configures the endpoint
config :daily_transaction_service, DailyTransactionService.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AZd8GE6RM+jcYIamo14KW7wx9M7BO55G6iAyUnJofinsN38SvELOqF6n3WrvMXLN",
  render_errors: [view: DailyTransactionService.ErrorView, accepts: ~w(json)],
  pubsub: [name: DailyTransactionService.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
