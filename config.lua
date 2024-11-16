Config = {}

Config.defaultlang = "de_lang"

-- Webhook Settings

Config.WebHook = false

Config.WHTitle = 'Trashcan: '
Config.WHLink = ''  -- Discord WH link Here
Config.WHColor = 16711680 -- red
Config.WHName = 'Trashcan: ' -- name
Config.WHLogo = '' -- must be 30x30px
Config.WHFooterLogo = '' -- must be 30x30px
Config.WHAvatar = '' -- must be 30x30px

-- Script Settings

Config.ResetCansTimer = 60 -- Time in Minutes
Config.TrashcanLimit = 250  -- Items Possible in Inventory 
Config.TrashcanCanBeEmpty = true
Config.Chance = 4 -- As lower the number as higher the chance to find item or money

Config.FindMoney = true
Config.MoneyMin = 5
Config.MoneyMax = 10

Config.FindItem = true

Config.TrashcanProp = 'p_streettrashcannbx01x'

Config.ItemToFind = {
    { Item = 'salt', Label = 'Salz', AmountMin = 3, AmountMax = 6 },
    { Item = 'hwood', Label = 'Hartholz', AmountMin = 3, AmountMax = 6 },
    { Item = 'wood', Label = 'Weichholz', AmountMin = 3, AmountMax = 6 },
    { Item = 'QuestToken', Label = 'Quest Token', AmountMin = 3, AmountMax = 6 },
}

Config.Trashcans = {  -- Trashcan Settings

    --- Blackwater
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-757.22, -1349.18, 43.65), TrashcanUniqueID = 'Blackwater1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-756.39, -1297.92, 43.64), TrashcanUniqueID = 'Blackwater2' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-732.36, -1236.06, 44.73), TrashcanUniqueID = 'Blackwater3' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-791.98, -1283.22, 43.63), TrashcanUniqueID = 'Blackwater4' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-808.64, -1307.12, 43.66), TrashcanUniqueID = 'Blackwater5' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-806.16, -1341.72, 43.66), TrashcanUniqueID = 'Blackwater6' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-813.93, -1393.64, 43.61), TrashcanUniqueID = 'Blackwater7' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-855.84, -1377.16, 43.62), TrashcanUniqueID = 'Blackwater8' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-844.64, -1325.44, 43.52), TrashcanUniqueID = 'Blackwater9' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-879.63, -1271.27, 43.39), TrashcanUniqueID = 'Blackwater10' },

    --- Tumbleweed
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-5516.49, -2919.65, -2.49), TrashcanUniqueID = 'Tumbleweed1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-5528.68, -2948.15, -1.45), TrashcanUniqueID = 'Tumbleweed2' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-5494.15, -2942.13, -1.05), TrashcanUniqueID = 'Tumbleweed3' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-5510.72, -3049.0, -2.36), TrashcanUniqueID = 'Tumbleweed4' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-5626.48, -2950.69, 5.87), TrashcanUniqueID = 'Tumbleweed5' },

    --- Amadillo
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-3689.51, -2587.08, -13.75), TrashcanUniqueID = 'Amadillo1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-3722.03, -2609.58, -13.25), TrashcanUniqueID = 'Amadillo2' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-3697.41, -2618.48, -13.85), TrashcanUniqueID = 'Amadillo3' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-3655.56, -2600.92, -13.16), TrashcanUniqueID = 'Amadillo4' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-3625.2, -2610.58, -13.73), TrashcanUniqueID = 'Amadillo5' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-3608.55, -2641.04, -11.46), TrashcanUniqueID = 'Amadillo6' },

    --- Strawberry
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-1836.53, -421.45, 160.95), TrashcanUniqueID = 'Strawberry1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-1800.89, -360.43, 163.66), TrashcanUniqueID = 'Strawberry2' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-1770.36, -383.05, 157.71), TrashcanUniqueID = 'Strawberry3' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-1777.04, -423.74, 155.06), TrashcanUniqueID = 'Strawberry4' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-1716.99, -431.22, 151.14), TrashcanUniqueID = 'Strawberry5' },

    --- Saint Denis
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2510.83, -1465.83, 46.33), TrashcanUniqueID = 'SaintDenis1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2629.06, -1429.38, 46.5), TrashcanUniqueID = 'SaintDenis2' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2802.66, -1326.46, 46.39), TrashcanUniqueID = 'SaintDenis3' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2726.55, -1289.06, 49.13), TrashcanUniqueID = 'SaintDenis4' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2630.66, -1288.32, 52.28), TrashcanUniqueID = 'SaintDenis5' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2717.02, -1248.7, 49.93), TrashcanUniqueID = 'SaintDenis6' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2596.82, -1206.89, 53.24), TrashcanUniqueID = 'SaintDenis7' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2622.04, -1232.97, 53.37), TrashcanUniqueID = 'SaintDenis8' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2661.27, -1176.83, 52.96), TrashcanUniqueID = 'SaintDenis9' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2659.73, -1124.5, 51.0), TrashcanUniqueID = 'SaintDenis10' },

    --- Van Horn
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(2973.57, 571.82, 44.36), TrashcanUniqueID = 'VanHorn1' },

    --- Valentine
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-279.48, 877.4, 121.18), TrashcanUniqueID = 'Valentine1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-258.68, 820.39, 120.57), TrashcanUniqueID = 'Valentine2' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-256.2, 754.87, 117.09), TrashcanUniqueID = 'Valentine3' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-260.97, 691.25, 113.33), TrashcanUniqueID = 'Valentine4' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-179.62, 617.39, 114.03), TrashcanUniqueID = 'Valentine5' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-335.46, 746.92, 116.85), TrashcanUniqueID = 'Valentine6' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-298.15, 784.22, 118.29), TrashcanUniqueID = 'Valentine7' },

    --- Rhodes
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(1237.14, -1281.46, 75.92), TrashcanUniqueID = 'Rhodes1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(1302.18, -1301.77, 76.47), TrashcanUniqueID = 'Rhodes2' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(1364.17, -1325.53, 77.47), TrashcanUniqueID = 'Rhodes3' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(1383.2, -1387.27, 78.95), TrashcanUniqueID = 'Rhodes4' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(1452.57, -1370.78, 78.82), TrashcanUniqueID = 'Rhodes5' },

    --- Oil Fields
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(502.09, 659.48, 117.36), TrashcanUniqueID = 'OilFields1' },

    --- Emerald Ranch
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(1517.29, 428.23, 90.68), TrashcanUniqueID = 'EmeraldRanch1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(1420.61, 324.35, 88.52), TrashcanUniqueID = 'EmeraldRanch2' },

    --- Limpany
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-364.48, -123.22, 46.57), TrashcanUniqueID = 'Limpany1' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-342.5, -125.09, 49.07), TrashcanUniqueID = 'Limpany2' },
    { TrashcanBlip = false, BlipSprite = 'blip_mp_location_q', TrashcanCoords = vector3(-372.48, -138.04, 47.3), TrashcanUniqueID = 'Limpany3' },


}
