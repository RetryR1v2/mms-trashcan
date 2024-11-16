local VORPcore = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()
local progressbar = exports.vorp_progressbar:initiate()

local CreatedTrashcanBlips = {}
local CreatedTrashcans = {}
local SearchedTrashcans = {}
local SearchedCans = false
local Distance = 11
local Searched = false

Citizen.CreateThread(function() -- Spawn Trashcans Blips and Stuff
    
    for h,v in ipairs(Config.Trashcans) do
        if v.TrashcanBlip then
            local CanBlips = BccUtils.Blips:SetBlip( _U('Trashcan'), v.BlipSprite, 3.0, v.TrashcanCoords.x, v.TrashcanCoords.y, v.TrashcanCoords.z )
            CreatedTrashcanBlips[#CreatedTrashcanBlips + 1] = CanBlips
        end
        local Trashcan = BccUtils.Objects:Create(Config.TrashcanProp, v.TrashcanCoords.x, v.TrashcanCoords.y, v.TrashcanCoords.z -1, 0, true, 'standard')
        CreatedTrashcans[#CreatedTrashcans + 1] = Trashcan
        Trashcan:Freeze(true)
        Trashcan:Invincible(true)
    end

end)

Citizen.CreateThread(function ()
    local StartTrashcanPrompt = BccUtils.Prompts:SetupPromptGroup()
    local SearchTrashcan = StartTrashcanPrompt:RegisterPrompt(_U('Search'), 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
    local UseTrashcan = StartTrashcanPrompt:RegisterPrompt(_U('UseInventory'), 0x27D1C284, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})

    while true do
        Wait(1)
        Searched = false
        local sleep = true
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        local CloseTrashcan = Citizen.InvokeNative(0xBFA48E2FF417213F, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 1.5,
            GetHashKey(Config.TrashcanProp), 0)
        for h,v in ipairs(SearchedTrashcans) do
            Distance = #(v - PlayerCoords)
            if Distance < 5 then
                Searched = true
            end
        end
        if CloseTrashcan and not Searched then
            sleep = false
            StartTrashcanPrompt:ShowGroup(_U('Trashcan'))
            if UseTrashcan:HasCompleted() then
                local MyCoords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent('mms-trashcans:server:openstorage',MyCoords)
            end
            if SearchTrashcan:HasCompleted() then
                Wait(500)
                SearchedTrashcans[#SearchedTrashcans + 1] = PlayerCoords
                SearchedCans = true
                SearchTrashcan:TogglePrompt(false)
                Wait(1000)
                SearchTrashcan:TogglePrompt(true)
                TriggerEvent('mms-trashcans:client:SearchTrashcan')
            end
            Searched = false
        end
        if sleep then
            Wait(1500)
        end
    end
end)



RegisterNetEvent('mms-trashcans:client:SearchTrashcan')
AddEventHandler('mms-trashcans:client:SearchTrashcan',function()
        CrouchAnim()
        progressbar.start(_U('SearchingBinProgressbar'), 7000, function ()
        end, 'linear')
        Wait(7000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('mms-trashcans:server:LookForItems')
end)

Citizen.CreateThread(function()
    while not SearchedCans do
        Citizen.Wait(5000)
        if SearchedCans then
            while true do
                Citizen.Wait(Config.ResetCansTimer * 60000)
                for i, v in ipairs(SearchedTrashcans) do  -- Tabelle leeren
                    SearchedTrashcans[i] = nil
                    SearchedCans = false
                end
            end
        end
    end
end)

----------------- Utilities -----------------

------ Animation

function CrouchAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskPlayAnim(ped, dict, "inspectfloor_player", 0.5, 8.0, -1, 1, 0, false, false, false)
end

------------------------- Clean Up on Resource Restart -----------------------------

RegisterNetEvent('onResourceStop',function(resource)
    if resource == GetCurrentResourceName() then
        for _, Trashcans in ipairs(CreatedTrashcans) do
            Trashcans:Remove()
	    end
        for _, blips in ipairs(CreatedTrashcanBlips) do
            blips:Remove()
	    end
    end
end)