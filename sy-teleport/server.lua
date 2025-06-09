local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("teleport:log")
AddEventHandler("teleport:log", function(locationMessage, webhookURL)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player or not webhookURL then return end

    local name = player.PlayerData.name

    local embed = {
        {
            ["color"] = 3447003,
            ["title"] = "Teleport Log",
            ["description"] = "**" .. name .. "** - " .. locationMessage,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S"),
            }
        }
    }

    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({
        username = "Lite Development",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end)
