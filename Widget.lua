-- ############################################################
-- FarmingUI Widgets
-- ############################################################

-- ------------------------------------------------------------
-- Retourne la couleur du marqueur de rareté
-- rarity:
-- 0 = pas de rareté
-- 1 = normal (argent)
-- 2 = rare (or)
-- ------------------------------------------------------------
local function GetRarityColor(rarity)
    if rarity == 2 then
       return 1.0, 0.82, 0.0 -- or
    elseif rarity == 1 then
        return 0.75, 0.75, 0.75 -- argent
    end

    return 0.45, 0.45, 0.45 -- gris / sans rareté
end

-- ------------------------------------------------------------
-- Crée une carte d'item
-- ------------------------------------------------------------
function Widgets_CreateItemCard(parent, itemData)
    local card = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    card:SetSize(36, 36)

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
    card.countText:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -2, 2)
    card.countText:SetTextColor(1, 1, 1)
    card.countText:SetJustifyH("RIGHT")
    card.countText:SetText(tostring(FarmingUI_Utils.CountItemInBags(itemData.itemID)))

    -- Couleur rareté
    local r, g, b = GetRarityColor(itemData.rarity)

    -- Petit badge rareté en haut à gauche
    card.rarityMark = CreateFrame("Frame", nil, card, "BackdropTemplate")
    card.rarityMark:SetSize(14, 14)
    card.rarityMark:SetPoint("TOPLEFT", card, "TOPLEFT", -3, 3)

    card.rarityMark:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 8,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    card.rarityMark:SetBackdropColor(r, g, b, 1)
    card.rarityMark:SetBackdropBorderColor(r * 0.75, g * 0.75, b * 0.75, 1)

    card.rarityMark.text = card.rarityMark:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    card.rarityMark.text:SetPoint("CENTER", card.rarityMark, "CENTER", 0, 0)
    card.rarityMark.text:SetTextColor(0.1, 0.1, 0.1)

    if itemData.rarity == 2 then
        card.rarityMark.text:SetText("R")
    elseif itemData.rarity == 1 then
        card.rarityMark.text:SetText("N")
    else
        card.rarityMark.text:SetText("-")
    end

    -- Bordure colorée légère selon rareté
    card.rarityGlow = card:CreateTexture(nil, "OVERLAY")
    card.rarityGlow:SetPoint("TOPLEFT", card, "TOPLEFT", 1, -1)
    card.rarityGlow:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -1, 1)
    card.rarityGlow:SetColorTexture(r, g, b, 0.12)

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
    local spacing = 5
    local cardWidth = 36
    local cardHeight = 36
    local titleHeight = 20

    -- Titre de section
    section.title = section:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    section.title:SetPoint("TOPLEFT", section, "TOPLEFT", 0, 0)
    section.title:SetTextColor(0.8, 0.8, 0.8)
    section.title:SetText(sectionData.label or "Section")

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