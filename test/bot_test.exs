defmodule BotTest do
  use ExUnit.Case
  import Mox
  setup :verify_on_exit!
  doctest Bot

  @bot_token "testToken"
  @chat %{"id" => "testChatId", "username" => "testChatUsername"}
  @message_id "testMessageId"

  describe "Bot.handle_update/2" do
    test "ignored update" do
      update = %{
        "my_chat_member" => %{
          "chat" => @chat,
          "message_id" => @message_id,
          "text" => "hello"
        }
      }

      assert :ok = Bot.handle_update(update, @bot_token)
    end

    test "message with unknown command" do
      expect(TelegramApiMock, :request, fn token, method, opts ->
        assert token == @bot_token
        assert method == "sendMessage"
        assert Keyword.get(opts, :chat_id) == @chat["id"]
        assert Keyword.get(opts, :reply_to_message_id) == @message_id
        assert Keyword.get(opts, :text) == "I don't know what to do with `hello` command."
      end)

      update = %{
        "message" => %{
          "chat" => @chat,
          "message_id" => @message_id,
          "text" => "hello"
        }
      }

      assert :ok = Bot.handle_update(update, @bot_token)
    end

    test "/start command" do
      expect(TelegramApiMock, :request, fn token, method, opts ->
        assert token == @bot_token
        assert method == "sendMessage"
        assert Keyword.get(opts, :chat_id) == @chat["id"]
        assert Keyword.get(opts, :reply_to_message_id) == @message_id
        assert Keyword.get(opts, :text) == "Hi #{@chat["username"]}, nice to meet you!"
      end)

      update = %{
        "message" => %{
          "chat" => @chat,
          "message_id" => @message_id,
          "text" => "/start"
        }
      }

      assert :ok = Bot.handle_update(update, @bot_token)
    end

    test "/ping command" do
      expect(TelegramApiMock, :request, fn token, method, opts ->
        assert token == @bot_token
        assert method == "sendMessage"
        assert Keyword.get(opts, :chat_id) == @chat["id"]
        assert Keyword.get(opts, :reply_to_message_id) == @message_id
        assert Keyword.get(opts, :text) == "pong!"
      end)

      update = %{
        "message" => %{
          "chat" => @chat,
          "message_id" => @message_id,
          "text" => "/ping"
        }
      }

      assert :ok = Bot.handle_update(update, @bot_token)
    end
  end
end
