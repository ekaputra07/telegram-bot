defmodule AppTest do
  use ExUnit.Case
  doctest App

  test "telegram_api" do
    assert App.telegram_api() == TelegramApiMock
  end
end
