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