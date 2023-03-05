# telegram-botx

> Work in progress!!

Bot Telegram UpKoding generasi terbaru (powered by Elixir).

### 👉 Development

1. Dapatkan Telegram bot token dari Telegram BotFather.
1. Jalankan Ngrok `ngrok http 4000` (sebagai reverse proxy bot yang berjalan di port 4000)
1. Buat file `.env` di direktori project, isinya:

    ```
    BOT_HOST=<NGROK-SUBDOMAIN-DISINI>.ngrok.io
    BOT_TOKEN=<BOT-TOKEN-DSINI>
    ```
1. Jalankan bot: `./script/dev` atau masuk ke linkungan dev `./script/dev bash`

### 👉 Deployment

Bot ini dijalankan di Fly.io, update `fly.toml` sesuai keperluan dan jangan lupa login ke fly.io dengan `fly` CLI.

Kemudian deploy dengan `fly launch` atau `fly deploy`.