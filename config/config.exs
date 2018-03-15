# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chat_rooms,
  ecto_repos: [ChatRooms.Repo]

# Configures the endpoint
config :chat_rooms, ChatRoomsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hp0A6qCqpQsT6svXxHlSvNf5WWBhoz+soHHGX0/aVplLNObaFYkFzU/yHA1bWbr9",
  render_errors: [view: ChatRoomsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChatRooms.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
