-- ############################################################
-- FarmingUI Widgets
-- ############################################################

-- ------------------------------------------------------------
-- Crée une carte d'item
-- ------------------------------------------------------------
function Widgets_CreateItemCard(parent, itemData)
    local card = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    local iconSize = FarmingUI_Config.Get("iconSize")
    card:SetSize(iconSize, iconSize)
    local fontSize = FarmingUI_Config.Get("fontSize")
    local badgeSize = FarmingUI_Config.Get("QualityBadge")

    -- Fond / bordure
    card:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 10,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    card:SetBackdropColor(0, 0, 0, 0.85)
    card:SetBackdropBorderColor(0.15, 0.15, 0.15, 1)

    -- Icône
    card.icon = card:CreateTexture(nil, "ARTWORK")
    card.icon:SetPoint("TOPLEFT", card, "TOPLEFT", 2, -2)
    card.icon:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -2, 2)
    card.icon:SetTexture(FarmingUI_Utils.GetItemIcon(itemData.itemID))
    card.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92) -- crop wow classique

    -- Quantité
    card.countText = card:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    card.countText:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
    card.countText:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -2, 2)
    card.countText:SetTextColor(1, 1, 1)
    card.countText:SetJustifyH("RIGHT")
    card.countText:SetText(tostring(FarmingUI_Utils.CountItemInBags(itemData.itemID)))

    -- Badge Rareté
    local atlas = FarmingUI_Utils.GetProfessionQualityAtlas(itemData.itemID)

    if atlas then
        card.qualityIcon = card:CreateTexture(nil, "OVERLAY")
        card.qualityIcon:SetSize(badgeSize,badgeSize)
        card.qualityIcon:SetPoint("TOPLEFT", card, "TOPLEFT", -2, 2)
        card.qualityIcon:SetAtlas(atlas)
    end

    -- Tooltip
    card:EnableMouse(true)
    card:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetItemByID(itemData.itemID)
        GameTooltip:Show()
    end)

    card:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Refresh
    function card:Refresh()
        self.icon:SetTexture(FarmingUI_Utils.GetItemIcon(itemData.itemID))
        self.countText:SetText(tostring(FarmingUI_Utils.CountItemInBags(itemData.itemID)))
    end

    return card
end

-- ------------------------------------------------------------
-- Crée un cadre de section complet
-- ------------------------------------------------------------
function Widgets_CreateSectionFrame(parent, sectionData)
    local section = CreateFrame("Frame", nil, parent)
    section.cards = {}

    local columns = sectionData.columns or 4
    local spacing = FarmingUI_Config.Get("spacing")
    local cardWidth = FarmingUI_Config.Get("iconSize")
    local cardHeight = FarmingUI_Config.Get("iconSize")
    local titleHeight = 0

    local itemCount = #sectionData.items
    local rows = math.ceil(itemCount / columns)

    local totalWidth = (columns * cardWidth) + ((columns - 1) * spacing)
    local totalHeight = titleHeight + 8 + (rows * cardHeight) + ((rows - 1) * spacing)

    section:SetSize(totalWidth, totalHeight)

    for index, itemData in ipairs(sectionData.items) do
        local card = Widgets_CreateItemCard(section, itemData)

        local col = (index - 1) % columns
        local row = math.floor((index - 1) / columns)

        local x = col * (cardWidth + spacing)
        local y = -(titleHeight + 8 + row * (cardHeight + spacing))

        card:SetPoint("TOPLEFT", section, "TOPLEFT", x, y)

        table.insert(section.cards, card)
    end

    function section:Refresh()
        for _, card in ipairs(self.cards) do
            card:Refresh()
        end
    end

    return section
end