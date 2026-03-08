local addonName = ...
local FarmingUI = {}

-- ############################################################
-- Frame principal
-- ############################################################

local frame = CreateFrame("Frame", "FarmingUI_MainFrame", UIParent)
frame:SetSize(1, 1)
frame:SetPoint("CENTER")

frame.sections = {}

frame:SetMovable(true)
frame:EnableMouse(true)
--frame:RegisterForDrag("LeftButton")

--frame:SetScript("OnDragStart", frame.StartMoving)
--frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

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

        --initialisation
        FarmingUI_Config.Init()
        print("|cff00ff00[FarmingUI]|r Loaded")

        local dataset = FarmingUI_Midnight
        local yOffset = -10

        for _, section in ipairs(dataset.sections) do
            if not section.profession or FarmingUI_Utils.PlayerHasProfession(section.profession) then
                local sectionFrame = Widgets_CreateSectionFrame(frame, section)
                sectionFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, yOffset)

                table.insert(frame.sections, sectionFrame)

                local sectionSpacing = 0
                yOffset = yOffset - sectionFrame:GetHeight() - sectionSpacing
            end
        end

        -- Deplacement addon  - alt + clic
        if frame.sections[1] and frame.sections[1].cards[1] then
            local dragHandle = frame.sections[1].cards[1]

            dragHandle:EnableMouse(true)
            dragHandle:RegisterForDrag("LeftButton")

            dragHandle:SetScript("OnDragStart", function()
                if IsAltKeyDown() then
                    frame:StartMoving()
                end
            end)

            dragHandle:SetScript("OnDragStop", function()
                frame:StopMovingOrSizing()
            end)
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