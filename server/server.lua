local VORPcore = exports.vorp_core:GetCore()

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
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Firstname = Character.firstname
    local Lastname = Character.lastname
    local MaxIndex = #Config.ItemToFind
    local RandomIndex = math.random(1,MaxIndex)
    local RewardItem = Config.ItemToFind[RandomIndex]
    local ItemAmount = math.random(RewardItem.AmountMin,RewardItem.AmountMax)
    local MoneyAmont = math.random(Config.MoneyMin,Config.MoneyMax)
    if Config.FindItem and not Config.FindMoney then
        local CanCarry = exports.vorp_inventory:canCarryItem(src, RewardItem.Item, ItemAmount)
            if CanCarry then
            exports.vorp_inventory:addItem(src, RewardItem.Item, ItemAmount, nil, nil)
            VORPcore.NotifyTip(src,_U('YouGetItem') .. ItemAmount .. ' ' .. RewardItem.Label,"right",4000)
            if Config.WebHook then
                VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. ItemAmount .. ' ' .. RewardItem.Label , Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
            end
        else
            VORPcore.NotifyTip(src,_U('NoInvetorySpace'),"right",4000)
        end
    end
    if Config.FindMoney and Config.FindItem then
        local CanCarry = exports.vorp_inventory:canCarryItem(src, RewardItem.Item, ItemAmount)
            if CanCarry then
            exports.vorp_inventory:addItem(src, RewardItem.Item, ItemAmount, nil, nil)
        end
        VORPcore.NotifyTip(src,_U('YouGetItem') .. ItemAmount .. ' ' .. RewardItem.Label .. _U('And') .. MoneyAmont ,"right",4000)
        Character.addCurrency(0,MoneyAmont)
        if Config.WebHook then
            VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. ItemAmount .. ' ' .. RewardItem.Label .. _U('And') .. MoneyAmont , Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
        end
    end
    if Config.FindMoney and not Config.FindItem then
        VORPcore.NotifyTip(src,_U('YouGetMoney') .. MoneyAmont,"right",4000)
        Character.addCurrency(0,MoneyAmont)
        if Config.WebHook then
            VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Firstname .. ' ' .. Lastname .. _U('WHFoundInCan') .. MoneyAmont .. ' $', Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
        end
    end
end)





RegisterServerEvent('mms-trashcans:server:openstorage', function()
    local src = source
    local isregistred = exports.vorp_inventory:isCustomInventoryRegistered('Trashcan')
        if isregistred then
            exports.vorp_inventory:closeInventory(src, 'Trashcan')
            exports.vorp_inventory:openInventory(src, 'Trashcan')
        else
            exports.vorp_inventory:registerInventory(
            {
                id = 'Trashcan',
                name = 'Mülleimer',
                limit = Config.TrashcanLimit,
                acceptWeapons = true,
                shared = true,
                ignoreItemStackLimit = true,
            }
            )
            exports.vorp_inventory:openInventory(src, 'Trashcan')
            isregistred = exports.vorp_inventory:isCustomInventoryRegistered('Trashcan')
        end
end)


Citizen.CreateThread(function ()
    while true do
        Wait(Config.ResetCansTimer * 60000)
        local isregistred = exports.vorp_inventory:isCustomInventoryRegistered('Trashcan')
        if isregistred then
        exports.vorp_inventory:deleteCustomInventory('Trashcan')
        exports.vorp_inventory:removeInventory('Trashcan')
        end
    end
end)


--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()