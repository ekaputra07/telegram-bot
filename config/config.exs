import Config

config :logger, :console, metadata: [:bot, :chat_id]

config :tesla,
  adapter: {Tesla.Adapter.Hackney, [recv_timeout: 40_000]}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
