## 🔧 SFS Chat Logger

A simple and efficient chat logger for FiveM servers that sends in-game chat messages directly to a Discord channel using webhooks. Perfect for moderation, record-keeping, or simply keeping an eye on your server’s chat activity.

---

### 📜 Features

- 📥 Logs all in-game chat messages
- 🔗 Sends messages directly to a Discord webhook
- 🛡️ Sanitizes @everyone, @here, and user/role mentions to prevent spam/pings
- 🔍 Logs player name, ID, and Discord ID (if available)
- 🖼️ Customizable bot name and avatar

---

### 📂 Files

- `server.lua` – Main script that hooks into chat messages and sends them to Discord
- `fxmanifest.lua` – Manifest file to register the resource

---

### ⚙️ Setup

1. Clone or download this repository into your server’s `resources` folder.
2. Update the `DISCORD_WEBHOOK`, `DISCORD_NAME`, and `DISCORD_IMAGE` variables in `chatlogger.lua` to your desired values.
3. Add the resource to your `server.cfg`:

```
ensure chat-logger
```

---

### ❗ Note

Make sure your Discord webhook has permissions to send messages in the selected channel.
