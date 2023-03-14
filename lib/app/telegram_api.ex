defmodule App.TelegramApiBehaviour do
  @moduledoc """
  Behaviour that represents Telegram.Api module.
  """
  @callback request(
              Telegram.Types.token(),
              Telegram.Types.method(),
              Telegram.Api.parameters()
            ) ::
              Telegram.Api.request_result()
  @callback file(Telegram.Types.token(), String.t()) :: Telegram.Api.request_result()
end

defmodule App.TelegramApi do
  @behaviour App.TelegramApiBehaviour

  defdelegate request(token, method, params \\ []), to: Telegram.Api
  defdelegate file(token, path), to: Telegram.Api
end
