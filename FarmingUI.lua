local addonName = ...
local FarmingUI = {}
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
frame.icon:SetTexture(ICON_TEXTURE)

-- ########################################################################
-- Déplacement ICON
-- ########################################################################
frame:RegisterEvent("OnDragStart", function(self)
    if IsAltKeyDown() then
        self:StartMoving()
    end
end)

frame:RegisterEvent("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)