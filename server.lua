local DISCORD_WEBHOOK = "Webhook_URL"
local DISCORD_NAME = "SYSTEM"
local DISCORD_IMAGE = "Image_URL"

local function sendDiscordWebhook(payload)
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers)
        if err ~= 200 then
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end


AddEventHandler('chatMessage', function(src, name, message)
    message = message:gsub("@everyone", "`@everyone`"):gsub("@here", "`@here`"):gsub("<@!?(%d+)>", "`<@!%1>`"):gsub("<@&?(%d+)>", "`<@&%1>`")

    local ids = ExtractIdentifiers(src)
    local discordId = ids.discord and ids.discord:gsub("discord:", "") or 'N/A'

    local payload = {
        username = name .. " [" .. src .. "]",
        content = message,
        tts = false,
        avatar_url = DISCORD_IMAGE 
    }

    sendDiscordWebhook(payload)
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then 
            identifiers.steam = id
        elseif string.find(id, "ip") then 
            identifiers.ip = id
        elseif string.find(id, "discord") then 
            identifiers.discord = id
        elseif string.find(id, "license") then 
            identifiers.license = id
        elseif string.find(id, "xbl") then 
            identifiers.xbl = id
        elseif string.find(id, "live") then 
            identifiers.live = id
        end
    end

    return identifiers
end
