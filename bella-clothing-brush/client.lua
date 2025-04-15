RegisterNetEvent("vorp:cleanClothes")
AddEventHandler("vorp:cleanClothes", function()
    print("[clothing_brush] Client received clean event")

    local player = PlayerPedId()

    -- Close inventory
    TriggerEvent("vorp_inventory:CloseInv")

    -- Start progress bar
    local progressbar = exports.vorp_progressbar:initiate()
    progressbar.start("Cleaning clothes...", 4000, function() end, "linear")

    -- Confirmed working animation
    local animDict = "amb_work@world_human_clean_table@male_a@base"
    local animName = "base"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    TaskPlayAnim(player, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

    Wait(4000)
    ClearPedTasks(player)

    -- Clean visual damage
    ClearPedBloodDamage(player)
    for zone = 0, 5 do
        ClearPedDamageDecalByZone(player, zone, "ALL")
    end

    -- Show tip
    TriggerEvent("vorp:TipRight", "Your clothes are now clean!", 4000)
end)
