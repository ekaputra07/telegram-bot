# telegram-bot

A starting point to create your own Telegram bot with Elixir.

### 👉 Development

A couple of helper scripts available under `scripts/` to ease development on your local machine.

Working on the bot locally:

1. Register your Bot using Telegram's `@BotFather` and get the token.
1. Start [**ngrok**](https://ngrok.com/) on port 8080 by running `ngrok http 8080` command. Ngrok will act as reverse proxy so Telegram could access your bot from the internet.
1. Create `.env` file and fill with environment variables that we'll pass to the app:

    ```
    BOT_HOST=<your-ngrok-subdomain-here>.ngrok.io
    BOT_TOKEN=<your-bot-token-here>
    ```
1. Start the bot with our helper script: `./script/dev`. It will start an _IEx_ shell (`iex -S mix`)
1. Start developing.

You'll want to update the `lib/bot.ex` to suit your need (handle messages or making replies).

### 👉 Deployment

It's up to you on how and where you want to deploy the bot. Here's how I deploy it to [Fly.io](https://fly.io/) as Docker container.

Prerequisites:

- Make sure you have an account at Fly.io
- Make sure you have `fly` CLI installed
- Make sure you're logged-in using `fly auth login`

Deploy steps:

1. Run `fly launch` and follow the steps (you only need to do this once and `fly.toml` file will be generated - see `fly.toml.example`)
1. Set bot environment variable as secrets:

    ```
    fly secrets set BOT_HOST=<your-fly-io-appname>.fly.dev
    fly secrets set BOT_TOKEN=<your-bot-token>
    ```
1. Run `fly deploy` to proceed with deployment.

Once finished, you will have the bot up and running and ready to accept messages.

### 👉 Demo bot

Open this link [t.me/ElixirDemoBot](https://t.me/ElixirDemoBot) and send `/ping` message, it will reply with `pong!`
