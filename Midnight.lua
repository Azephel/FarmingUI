-- ############################################################
-- FarmingUI Dataset : Midnight
-- ############################################################
-- Rarity 0 = no rarity
--        1 = Normal
--        2 = Rare
-- ############################################################

FarmingUI_Midnight = {
    name = "Midnight",

    sections = {

        {-- Herbalism
            id = "herbs",
            label = "herbs",
            profession = "herbalism",
            columns = 6,

            items = {
                { itemID = 236761, label = "Tranquilette" },
                { itemID = 236776, label = "Feuille d'argent" },
                { itemID = 236778, label = "Lys de mana" },
                { itemID = 236770, label = "Sanguironce" },
                { itemID = 236774, label = "Azéracine" },

                { itemID = 236780, label = "Lotus nocturne" },
                
                { itemID = 236767, label = "Tranquilette" },                
                { itemID = 236777, label = "Feuille d'argent" },                
                { itemID = 236779, label = "Lys de mana" },                
                { itemID = 236771, label = "Sanguironce" },
                { itemID = 236775, label = "Azéracine" },
            },
        },

        { -- Mining
            id = "ore",
            label = "ore",
            profession = "mining",
            columns = 4,

            items = {
                { itemID = 237364, label = "argent brillant" },
                { itemID = 237362, label = "étain ombreux" },
                { itemID = 237359, label = "cuivre éclatant" },
                
                { itemID = 237366, label = "Thorium éblouissant" },

                { itemID = 237365, label = "argent brillant" },
                { itemID = 237363, label = "étain ombreux" },
                { itemID = 237361, label = "cuivre éclatant" },
            },
        },
    },
}