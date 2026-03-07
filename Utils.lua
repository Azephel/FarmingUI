-- ############################################################
-- FarmingUI Utilities
-- ############################################################

FarmingUI_Utils = {}

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