local VorpCore = {}
local VorpInv = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
    while VorpCore == nil or VorpInv == nil do
        Citizen.Wait(100)
    end

    print("[clothing_brush] Registering usable item")

    VorpInv.RegisterUsableItem("clothing_brush", function(data)
        local source = data.source
        print("[clothing_brush] Callback triggered for source:", source)

        if not VorpCore.getUser then
            print("[clothing_brush] VorpCore.getUser is nil!")
            return
        end

        local user = VorpCore.getUser(source)
        if not user then
            print("[clothing_brush] getUser returned nil for source:", source)
            return
        end

        local character = user.getUsedCharacter
        if not character then
            print("[clothing_brush] getUsedCharacter returned nil")
            return
        end

        -- ✅ Correct way to remove the item with VORP Inventory API
        VorpInv.subItem(source, "clothing_brush", 1)

        -- ✅ Trigger cleaning
        TriggerClientEvent("vorp:cleanClothes", source)
    end)
end)
