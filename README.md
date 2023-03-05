# telegram-bot

A boilerplace code to create your own Telegram bot using Elixir.

This project is just a plain Elixir app. A couple of helper scripts available under `scripts/` to ease development on your local machine.

### 👉 Development

Development is easy thanks to Docker and Docker compose, they allows us to work on Elixir app without having Elixir installed on our machine.

Working on the bot locally:

1. Register your Bot using Telegram's `@BotFather` and get the bot token.
1. Start [**ngrok**](https://ngrok.com/) on http port 8080 by running `ngrok http 8080`. This will act as reverse proxy to your bot's port since we're using webhook method to handle the message.
1. Create `.env` file and fill it with environment variables that we'll pass to the app:

    ```
    BOT_HOST=<your-ngrok-subdomain-here>.ngrok.io
    BOT_TOKEN=<your-bot-token-here>
    ```
1. Start the bot with the helper script: `./script/dev`. It will start an `iex` shell (`iex -S mix`)
1. Start developing.

You'll want to update the `lib/bot.ex` to suit your need (handle messages and make replies).

### 👉 Deployment

It's up to you on how to and where you want to deploy your bot. My favorite method is Docker image and deploy it anywhere that support Docker deployment.

Here how I deploy to [Fly.io](https://fly.io/).

Pre-requisites:

- Make sure you have an account at Fly.io
- Make sure you have `fly` CLI installed
- Make sure you're logged-in using `fly auth login`

Deploy steps:

1. Run `fly launch` and follow required steps (you only need to do this once and `fly.toml` file will generated - see `fly.toml.example`)
1. Set bot environment variable as secrets:

    ```
    fly secrets set BOT_HOST=<your-fly-io-appname>.fly.dev
    fly secrets set BOT_TOKEN=<your-bot-token>
    ```
1. Run `fly deploy` to proceed with deployment.

If everything works as expected we'll have our bot up and running on fly.io and you can start sending it messages (commands).

### 👉 Demo bot

Open this link [t.me/ElixirDemoBot](t.me/ElixirDemoBot) and send it `/ping` message and it will reply with `pong!` or send any message (unknown commands) and see the replies.