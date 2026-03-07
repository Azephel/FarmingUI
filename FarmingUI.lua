local addonName = ...
local FarmingUI = {}

-- ############################################################
-- Frame principal
-- ############################################################

local frame = CreateFrame("Frame", "FarmingUI_MainFrame", UIParent)
frame:SetSize(600, 400)
frame:SetPoint("CENTER")

frame.sections = {}

frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")

frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

-- ############################################################
-- Chargement addon
-- ############################################################

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("BAG_UPDATE_DELAYED")

frame:SetScript("OnEvent", function(self, event, name)

    if event == "ADDON_LOADED" then
        if name ~= addonName then
            return
        end

        print("|cff00ff00[FarmingUI]|r Loaded")

        local dataset = FarmingUI_Midnight
        local yOffset = -10

        for _, section in ipairs(dataset.sections) do
            local sectionFrame = Widgets_CreateSectionFrame(frame, section)
            sectionFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, yOffset)

            table.insert(frame.sections, sectionFrame)

            yOffset = yOffset - sectionFrame:GetHeight() - 20
        end

        return
    end

    if event == "BAG_UPDATE_DELAYED" then
        for _, sectionFrame in ipairs(frame.sections) do
            sectionFrame:Refresh()
        end
        return
    end
end)