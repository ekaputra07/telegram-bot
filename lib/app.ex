defmodule App do
  @doc """
  Return Telegram API client that is set via config, default to: App.TelegramApi
  This will allow us to replace (mock) the client on test env.

  Bots must use this function to get API client to make it easier to test
  bot logic.
  """
  def telegram_api do
    Application.get_env(:app, :telegram_api, App.TelegramApi)
  end
end
