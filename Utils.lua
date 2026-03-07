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