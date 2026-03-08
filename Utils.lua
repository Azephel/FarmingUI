-- ############################################################
-- FarmingUI Utilities
-- ############################################################

FarmingUI_Utils = {}

-- liste id des metier
FarmingUI_Utils.Professions = {
    Alchemy      = 171,
    Blacksmith   = 164,
    Enchanting   = 333,
    Engineering  = 202,
    Herbalism    = 182,
    Inscription  = 773,
    Jewelcraft   = 755,
    Leatherwork  = 165,
    Mining       = 186,
    Skinning     = 393,
    Tailoring    = 197,
    Cooking      = 185,
    Fishing      = 356,
    Archaeology  = 794,
}

-- ------------------------------------------------------------
-- Retourne l'icône d'un item à partir de son ID
-- ------------------------------------------------------------
function FarmingUI_Utils.GetItemIcon(itemID)
    local _, _, _, _, icon = GetItemInfoInstant(itemID)
    return icon
end

-- ------------------------------------------------------------
-- Compte le nombre total d'un item dans les sacs
-- ------------------------------------------------------------
function FarmingUI_Utils.CountItemInBags(itemID)

    local total = 0

    local function ScanBag(bagID)
        local numSlots = C_Container.GetContainerNumSlots(bagID)

        for slot = 1, numSlots do
            local info = C_Container.GetContainerItemInfo(bagID, slot)
            if info and info.itemID == itemID then
                total = total + (info.stackCount or 0)
            end
        end
    end

    -- Sac à dos + sacs équipés classiques
    for bag = 0, NUM_BAG_SLOTS do
        ScanBag(bag)
    end

    -- Sac de composants / reagent bag
    ScanBag(Enum.BagIndex.ReagentBag)

    return total
end

-- ------------------------------------------------------------
-- Recuperation du badge de rareté
-- ------------------------------------------------------------
function FarmingUI_Utils.GetProfessionQuality(itemID)

    if not C_TradeSkillUI then
        return 0
    end

    local q = C_TradeSkillUI.GetItemReagentQualityByItemInfo(itemID)

    return q or 0
end

-- ------------------------------------------------------------
-- Recuperation de l'atlas de rareté
-- ------------------------------------------------------------
function FarmingUI_Utils.GetProfessionQualityAtlas(itemID)

    local q = FarmingUI_Utils.GetProfessionQuality(itemID)

    if q == 0 then
        return nil
    end

    return "Professions-ChatIcon-Quality-12-Tier"..q
end

-- ------------------------------------------------------------
-- Recuperation des metiers
-- ------------------------------------------------------------
function FarmingUI_Utils.PlayerHasProfession(professionIDs)
    if not professionIDs then
        return true
    end

    local knownProfessions = {}

    local prof1, prof2, archaeology, fishing, cooking = GetProfessions()
    local professionIndexes = { prof1, prof2, archaeology, fishing, cooking }

    for _, professionIndex in ipairs(professionIndexes) do
        if professionIndex then
            local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine = GetProfessionInfo(professionIndex)
            if skillLine then
                knownProfessions[skillLine] = true
            end
        end
    end

    for _, wantedID in ipairs(professionIDs) do
        if knownProfessions[wantedID] then
            return true
        end
    end

    return false
end