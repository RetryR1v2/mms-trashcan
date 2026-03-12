local Core = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()
local progressbar = exports.vorp_progressbar:initiate()

local CreatedTrashcanBlips = {}
local CreatedTrashcans = {}
local SearchedTrashcans = {}
local SearchedCans = false

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
    local SearchTrashcan = StartTrashcanPrompt:RegisterPrompt(_U('Search'), 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'}) -- G
    local UseTrashcan = StartTrashcanPrompt:RegisterPrompt(_U('UseInventory'), 0x27D1C284, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'}) -- R
    local ClearTrashcan = StartTrashcanPrompt:RegisterPrompt(_U('EmptyTrash'), 0x0522B243, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'}) -- F

    while true do
        Wait(1)
        local sleep = true
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        local CloseTrashcan = Citizen.InvokeNative(0xBFA48E2FF417213F, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 1.5,
            GetHashKey(Config.TrashcanProp), 0)

        -- Check if this specific trashcan location has been searched (cooldown)
        local AlreadySearched = false
        for h,v in ipairs(SearchedTrashcans) do
            if #(v - PlayerCoords) < 5 then
                AlreadySearched = true
                break
            end
        end

        if CloseTrashcan then
            sleep = false
            StartTrashcanPrompt:ShowGroup(_U('Trashcan'))

            -- Always allow Open and Empty regardless of search cooldown
            if UseTrashcan:HasCompleted() then
                local MyCoords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent('mms-trashcans:server:openstorage', MyCoords)
            end

            if ClearTrashcan:HasCompleted() then
                local MyCoords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent('mms-trashcans:server:clearInventory', MyCoords)
            end

            -- Only allow Search if not on cooldown
            if AlreadySearched then
                SearchTrashcan:TogglePrompt(false)
            else
                SearchTrashcan:TogglePrompt(true)
                if SearchTrashcan:HasCompleted() then
                    SearchedTrashcans[#SearchedTrashcans + 1] = PlayerCoords
                    SearchedCans = true
                    SearchTrashcan:TogglePrompt(false)
                    Wait(500)
                    TriggerEvent('mms-trashcans:client:SearchTrashcan')
                end
            end
        else
            -- Not near a trashcan — restore search prompt visibility for next approach
            SearchTrashcan:TogglePrompt(true)
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
    while true do
        Citizen.Wait(Config.ResetCansTimer * 60000)
        if SearchedCans then
            SearchedTrashcans = {}
            SearchedCans = false
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