local addonName = ...
local FarmingUI = {}

local ICON_TEXTURE = 236774

-- ########################################################################
-- Création Frame principal
-- ########################################################################
local frame = CreateFrame("Frame", "FarmingUI_MainFrame", UIParent, "BackdropTemplate")
FarmingUI.frame = frame

frame:SetSize(48, 48)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")

-- ########################################################################
-- Fond Simple
-- ########################################################################
frame.bg = frame:CreateTexture(nil, "BACKGROUND")
frame.bg:SetAllPoints(frame)
frame.bg:SetColorTexture(0, 0, 0, 0.35)

-- ########################################################################
-- Icone
-- ########################################################################
frame.icon = frame:CreateTexture(nil, "ARTWORK")
frame.icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
frame.icon:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
frame.icon:SetTexture(FarmingUI_Utils.GetItemIcon(ICON_TEXTURE))

-- ########################################################################
-- Textes de quantité
-- ########################################################################
frame.normalText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frame.normalText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 4, 4)
frame.normalText:SetTextColor(0.75, 0.75, 0.75) -- argent
frame.normalText:SetText("0")

frame.rareText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frame.rareText:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
frame.rareText:SetTextColor(1.0, 0.82, 0.0) -- or
frame.rareText:SetText("0")

-- ########################################################################
-- Marqueurs visuels de rareté
-- ########################################################################
frame.normalMark = frame:CreateTexture(nil, "OVERLAY")
frame.normalMark:SetSize(8, 8)
frame.normalMark:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 6)
frame.normalMark:SetColorTexture(0.75, 0.75, 0.75, 1) -- argent

frame.rareMark = frame:CreateTexture(nil, "OVERLAY")
frame.rareMark:SetSize(8, 8)
frame.rareMark:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -6)
frame.rareMark:SetColorTexture(1.0, 0.82, 0.0, 1) -- or

-- ########################################################################
-- Déplacement ICON -- Alt + clic gauche
-- ########################################################################
frame:SetScript("OnDragStart", function(self)
    if IsAltKeyDown() then
        self:StartMoving()
    end
end)

frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)