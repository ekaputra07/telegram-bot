defmodule App.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    webhook_config = [
      host: Application.fetch_env!(:app, :host),
      local_port: Application.fetch_env!(:app, :local_port)
    ]

    bot_config = [
      token: Application.fetch_env!(:app, :bot_token),
      max_bot_concurrency: Application.fetch_env!(:app, :max_bot_concurrency)
    ]

    children = [
      {Telegram.Webhook, config: webhook_config, bots: [{Bot, bot_config}]}
    ]

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
