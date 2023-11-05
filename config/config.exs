import Config

config :logger, :console, metadata: [:bot, :chat_id]

config :tesla,
  adapter: {Tesla.Adapter.Hackney, [recv_timeout: 40_000]}

config :telegram,
  webserver: Telegram.WebServer.Cowboy

config :app,
  start_bot: true

# Don't start Bot process on :test env
if config_env() == :test do
  config :app,
    start_bot: false
end
