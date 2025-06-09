local locations = {
    {
        interaction = vector3(135.26, -763.58, 242.15), -- 1. etkileşim noktası
        teleport = vector3(-66.8, -802.35, 44.23),     -- 1. teleport noktası
        message = "Asansör İle Aşşağı İndi [DOJ]",
        webhook = "WEEBHOOK GİRİNİZ"                 
    },
    {
        interaction = vector3(-66.8, -802.35, 44.23), -- 2. etkileşim noktası
        teleport = vector3(135.26, -763.58, 242.15),    -- 2. teleport noktası
        message = "Asansör İle Yukarı Çıktı [DOJ]",
        webhook = "WEEBHOOK GİRİNİZ"                   
    }
}

local interactionRange = 2.0

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local sleep = 1000

        for _, loc in pairs(locations) do
            local dist = #(playerCoords - loc.interaction)
            if dist < interactionRange then
                sleep = 0
                DrawText3D(loc.interaction.x, loc.interaction.y, loc.interaction.z + 1.0, "[E] Teleport Ol")
                if IsControlJustReleased(0, 38) then -- E tuşu
                    SetEntityCoords(playerPed, loc.teleport.x, loc.teleport.y, loc.teleport.z)
                    TriggerServerEvent("teleport:log", loc.message, loc.webhook)
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
