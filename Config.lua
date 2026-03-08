-- ############################################################
-- FarmingUI Config
-- ############################################################

FarmingUI_Config = {}

FarmingUI_Config.defaults = {
    iconSize = 36,
    spacing = 5,
    fontSize = 12,
    sectionSpacing = 4,
    showQualityBadge = true,
    QualityBadge = 14,
}

function FarmingUI_Config.Init()
    FarmingUI_DB = FarmingUI_DB or {}

    for key, value in pairs(FarmingUI_Config.defaults) do
        if FarmingUI_DB[key] == nil then
            FarmingUI_DB[key] = value
        end
    end
end

function FarmingUI_Config.Get(key)
    if FarmingUI_DB and FarmingUI_DB[key] ~= nil then
        return FarmingUI_DB[key]
    end

    return FarmingUI_Config.defaults[key]
end

function FarmingUI_Config.Set(key, value)
    FarmingUI_DB = FarmingUI_DB or {}
    FarmingUI_DB[key] = value
end