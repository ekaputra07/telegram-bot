import Config

# Runtime specific config

config :app,
  host: System.get_env("BOT_HOST"),
  bot_token: System.get_env("BOT_TOKEN"),
  max_bot_concurrency: System.get_env("MAX_BOT_CONCURRENCY", "1000") |> String.to_integer(),
  local_port: System.get_env("PORT", "8080") |> String.to_integer()
