defmodule App.Application do
  @moduledoc false

  use Application
  require Config

  @impl true
  def start(_type, _args) do
    # bot webhook configuration
    webhook_config = [
      host: Application.fetch_env!(:app, :host),
      local_port: Application.fetch_env!(:app, :local_port)
    ]

    # bot configuration
    bot_config = [
      token: Application.fetch_env!(:app, :bot_token),
      max_bot_concurrency: Application.fetch_env!(:app, :max_bot_concurrency)
    ]

    # add our bot under supervision tree only if :start_bot config == true
    # as we don't want to start the bot on :test env
    children =
      case Application.fetch_env!(:app, :start_bot) do
        true -> [{Telegram.Webhook, config: webhook_config, bots: [{Bot, bot_config}]}]
        _ -> []
      end

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
