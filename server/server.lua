local Core = exports.vorp_core:GetCore()
local CreatedInventorys = {}
-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/RetryR1v2/mms-trashcan/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

      
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('Current Version: %s'):format(currentVersion))
            versionCheckPrint('success', ('Latest Version: %s'):format(text))
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

RegisterServerEvent('mms-trashcans:server:LookForItems',function()
    local src = source
    local Character = Core.getUser(src).getUsedCharacter
    local Firstname = Character.firstname
    local Lastname = Character.lastname
    local MaxIndex = #Config.ItemToFind
    local RandomIndex = math.random(1,MaxIndex)
    local RewardItem = Config.ItemToFind[RandomIndex]
    local ItemAmount = math.random(RewardItem.AmountMin,RewardItem.AmountMax)
    local MoneyAmont = math.random(Config.MoneyMin,Config.MoneyMax)
    local Chance = math.random(1,10)
    if Config.TrashcanCanBeEmpty then
        if Chance > Config.Chance then
        if Config.FindItem and not Config.FindMoney then
            local CanCarry = exports.vorp_inventory:canCarryItem(src, RewardItem.Item, ItemAmount)
                if CanCarry then
                exports.vorp_inventory:addItem(src, RewardItem.Item, ItemAmount, nil, nil)
                Core.NotifyLeft(src,_U('YouGetItem') .. ItemAmount .. ' ' .. RewardItem.Label,"right",4000)
                if Config.WebHook then
                    Core.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. ItemAmount .. ' ' .. RewardItem.Label , Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
                end
            else
                Core.NotifyLeft(src,_U('NoInvetorySpace'),"right",4000)
            end
        end
        if Config.FindMoney and Config.FindItem then
            local CanCarry = exports.vorp_inventory:canCarryItem(src, RewardItem.Item, ItemAmount)
                if CanCarry then
                exports.vorp_inventory:addItem(src, RewardItem.Item, ItemAmount, nil, nil)
            end
            Core.NotifyLeft(src,_U('YouGetItem') .. ItemAmount .. ' ' .. RewardItem.Label .. _U('And') .. MoneyAmont ,"right",4000)
            Character.addCurrency(0,MoneyAmont)
            if Config.WebHook then
                Core.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. ItemAmount .. ' ' .. RewardItem.Label .. _U('And') .. MoneyAmont , Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
            end
        end
        if Config.FindMoney and not Config.FindItem then
            Core.NotifyLeft(src,_U('YouGetMoney') .. MoneyAmont,"right",4000)
            Character.addCurrency(0,MoneyAmont)
            if Config.WebHook then
                Core.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. MoneyAmont .. ' $', Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
            end
        end
    else
        Core.NotifyLeft(src,_U('TashcanWasEmpty'),"right",4000)
    end
else
    if Config.FindItem and not Config.FindMoney then
        local CanCarry = exports.vorp_inventory:canCarryItem(src, RewardItem.Item, ItemAmount)
            if CanCarry then
            exports.vorp_inventory:addItem(src, RewardItem.Item, ItemAmount, nil, nil)
            Core.NotifyLeft(src,_U('YouGetItem') .. ItemAmount .. ' ' .. RewardItem.Label,"right",4000)
            if Config.WebHook then
                Core.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. ItemAmount .. ' ' .. RewardItem.Label , Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
            end
        else
            Core.NotifyLeft(src,_U('NoInvetorySpace'),"right",4000)
        end
    end
    if Config.FindMoney and Config.FindItem then
        local CanCarry = exports.vorp_inventory:canCarryItem(src, RewardItem.Item, ItemAmount)
            if CanCarry then
            exports.vorp_inventory:addItem(src, RewardItem.Item, ItemAmount, nil, nil)
        end
        Core.NotifyLeft(src,_U('YouGetItem') .. ItemAmount .. ' ' .. RewardItem.Label .. _U('And') .. MoneyAmont ,"right",4000)
        Character.addCurrency(0,MoneyAmont)
        if Config.WebHook then
            Core.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. ItemAmount .. ' ' .. RewardItem.Label .. _U('And') .. MoneyAmont , Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
        end
    end
    if Config.FindMoney and not Config.FindItem then
        Core.NotifyLeft(src,_U('YouGetMoney') .. MoneyAmont,"right",4000)
        Character.addCurrency(0,MoneyAmont)
        if Config.WebHook then
            Core.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. MoneyAmont .. ' $', Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
        end
    end
end
end)

RegisterServerEvent('mms-trashcans:server:openstorage', function(MyCoords)
    local src = source
    local TrashcanFound = false
    for h,v in ipairs(Config.Trashcans) do
        if not TrashcanFound then
            local Distance = #(v.TrashcanCoords - MyCoords)
            if Distance < 3 then
                TrashcanFound = true
                local isregistred = exports.vorp_inventory:isCustomInventoryRegistered(v.TrashcanUniqueID)
                if isregistred then
                    exports.vorp_inventory:closeInventory(src, v.TrashcanUniqueID)
                    exports.vorp_inventory:openInventory(src, v.TrashcanUniqueID)
                else
                    exports.vorp_inventory:registerInventory(
                    {
                        id = v.TrashcanUniqueID,
                        name = 'Mülleimer',
                        limit = Config.TrashcanLimit,
                        acceptWeapons = true,
                        shared = true,
                        ignoreItemStackLimit = true,
                    })
                    exports.vorp_inventory:openInventory(src, v.TrashcanUniqueID)
                    isregistred = exports.vorp_inventory:isCustomInventoryRegistered(v.TrashcanUniqueID)
                    CreatedInventorys[#CreatedInventorys + 1] = v.TrashcanUniqueID
                end
            end
        end
    end

    if not TrashcanFound then
        local isregistred = exports.vorp_inventory:isCustomInventoryRegistered('WorldmapTrashcan')
        if isregistred then
            exports.vorp_inventory:closeInventory(src, 'WorldmapTrashcan')
            exports.vorp_inventory:openInventory(src, 'WorldmapTrashcan')
        else
            exports.vorp_inventory:registerInventory(
            {
                id = 'WorldmapTrashcan',
                name = 'Trashcan',
                limit = Config.TrashcanLimit,
                acceptWeapons = true,
                shared = true,
                ignoreItemStackLimit = true,
            })
            exports.vorp_inventory:openInventory(src, 'WorldmapTrashcan')
            isregistred = exports.vorp_inventory:isCustomInventoryRegistered('WorldmapTrashcan')
            CreatedInventorys[#CreatedInventorys + 1] = 'WorldmapTrashcan'
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Wait(Config.ResetCansTimer * 60000)
        for h,v in ipairs(CreatedInventorys) do
            local isregistred = exports.vorp_inventory:isCustomInventoryRegistered(v)
            if isregistred then
            exports.vorp_inventory:deleteCustomInventory(v)
            exports.vorp_inventory:removeInventory(v)
            end
        end
    end
end)

RegisterServerEvent('mms-trashcans:server:clearInventory', function(coords)
    local src = source

    local function GetDistanceBetween(vec1, vec2)
        return math.sqrt((vec1.x - vec2.x)^2 + (vec1.y - vec2.y)^2 + (vec1.z - vec2.z)^2)
    end

    for _, v in ipairs(Config.Trashcans) do
        local dist = GetDistanceBetween(v.TrashcanCoords, coords)
        if dist < 3.0 then
            if exports.vorp_inventory:isCustomInventoryRegistered(v.TrashcanUniqueID) then
                exports.vorp_inventory:deleteCustomInventory(v.TrashcanUniqueID)
                exports.vorp_inventory:removeInventory(v.TrashcanUniqueID)
                Core.NotifyLeft(src, _U('TrashEmptied'), "right", 3000)
            else
                Core.NotifyLeft(src, _U('TashcanWasEmpty'), "right", 3000)
            end
            return
        end
    end
end)

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()
