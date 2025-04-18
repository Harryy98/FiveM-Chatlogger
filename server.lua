local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1274439838250045460/KaMnmIMZZkpJa-b1ovwe0sHWXRWLnh01hUl6vpqqhVBkgNiV4XkG9bFhN0hnUq60IKdR"
local DISCORD_NAME = "SFS"
local DISCORD_IMAGE = "https://cdn.discordapp.com/attachments/1120606708532793404/1274441562591330417/logo.png?ex=66c8db32&is=66c789b2&hm=d86806956eb908be0fba7d8205ce732b490689d1126551861ec2ea8f600ad515&"

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
