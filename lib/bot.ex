defmodule Bot do
  @moduledoc """
  An example of Telegram bot command handlers.
  """

  use Telegram.Bot
  require Logger

  @impl Telegram.Bot
  @doc """
  Handle update type `message`, other types are ignored.
  """
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
    Logger.debug(message)
  end

  # helper function to reply a message
  defp reply(token, chat_id, message_id, message) do
    Telegram.Api.request(token, "sendMessage",
      chat_id: chat_id,
      reply_to_message_id: message_id,
      text: message
    )

    :ok
  end

  # handle `/start` command
  defp handle_chat("/start", %{"id" => chat_id, "username" => username}, message_id, token) do
    reply(token, chat_id, message_id, "Hi #{username}, nice to meet you!")
  end

  # handle `/ping` command, reply with pong!
  defp handle_chat("/ping", %{"id" => chat_id}, message_id, token) do
    reply(token, chat_id, message_id, "pong!")
  end

  # handle unknown command
  defp handle_chat(text, %{"id" => chat_id}, message_id, token) do
    reply(token, chat_id, message_id, "I don't know what to do with `#{text}` command.")
  end
end
