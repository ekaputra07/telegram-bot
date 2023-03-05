defmodule Bot do
  use Telegram.Bot
  require Logger

  @impl Telegram.Bot
  def handle_update(
        %{
          "message" => %{
            "chat" => chat,
            "message_id" => message_id,
            "text" => text
          }
        },
        token
      ) do
    handle_chat(text, chat, message_id, token)
  end

  @impl Telegram.Bot
  def handle_update(message, _token) do
    Logger.info("Message ignored:")
    Logger.info(message)
  end

  defp reply(token, chat_id, message_id, message) do
    Telegram.Api.request(token, "sendMessage",
      chat_id: chat_id,
      reply_to_message_id: message_id,
      text: message
    )

    :ok
  end

  defp handle_chat("/start", %{"id" => chat_id, "username" => username}, message_id, token) do
    reply(token, chat_id, message_id, "Halo #{username}, senang berkenalam dengan kamu.")
  end

  defp handle_chat("/you", %{"id" => chat_id}, message_id, token) do
    case Telegram.Api.request(token, "getMe") do
      {:ok, me} -> reply(token, chat_id, message_id, inspect(me))
      _ -> reply(token, chat_id, message_id, "Maaf, data tidak ditemukan.")
    end
  end

  defp handle_chat("/me", %{"id" => chat_id} = chat, message_id, token) do
    reply(token, chat_id, message_id, inspect(chat))
  end

  defp handle_chat(_text, %{"id" => chat_id}, message_id, token) do
    reply(token, chat_id, message_id, "Maaf, perintah tidak dikenali!")
  end
end
