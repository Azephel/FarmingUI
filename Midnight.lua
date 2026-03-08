-- ############################################################
-- FarmingUI Dataset : Midnight
-- ############################################################
-- metiers légaux : 171 = Alchemy
--                  164 = Blacksmithing
--                  333 = Enchanting
--                  202 = Engineering
--                  182 = Herbalism
--                  773 = Inscription
--                  755 = Jewelcrafting
--                  165 = Leatherworking
--                  186 = Mining
--                  393 = Skinning
--                  197 = Tailoring
---------------------------------------------------------------
--                  185 = Cooking
--                  356 = Fishing
--                  794 = Archaeology
-- ############################################################

FarmingUI_Midnight = {
    name = "Midnight",

    sections = {

        {-- Herbalism
            id = "herbs",
            label = "herbs",
            profession = {182},
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
            profession = {186},
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

        { -- Depessage
            id = "Leather",
            label = "Leather",
            profession = {165},
            columns = 2,

            items = {
                { itemID = 238512, label = "Cuir tanné par le Vide" },
                { itemID = 238514, label = "Écailles altérées par le Vide" },

                { itemID = 238519, label = "Cuir tanné par le Vide" },
                { itemID = 238521, label = "Écailles altérées par le Vide" },

                --{ itemID = 238522, label = "Plumage incomparable" },
                --{ itemID = 238528, label = "Griffe majestueuse" },

                --{ itemID = 238525, label = "Fourrure fantastique" },
                --{ itemID = 238530, label = "Nageoire majestueuse" },
                
                --{ itemID = 238523, label = "Canine tranchante" },
                --{ itemID = 238529, label = "Peau majestueuse" },
            },
        },
        { -- Depessage special
            id = "Leather",
            label = "Leather",
            profession = {165},
            columns = 3,

            items = {
                { itemID = 238522, label = "Plumage incomparable" },
                { itemID = 238525, label = "Fourrure fantastique" },
                { itemID = 238523, label = "Canine tranchante" },
                
                { itemID = 238528, label = "Griffe majestueuse" },
                { itemID = 238530, label = "Nageoire majestueuse" },
                { itemID = 238529, label = "Peau majestueuse" },
                
            },
        },

        { -- Regents
            id = "Regent",
            label = "Regeant",
            profession = {182, 186},
            columns = 4,

            items = {
                { itemID = 236949, label = "particules de Lumiere" },
                { itemID = 236952, label = "particules de vide pur" },
                { itemID = 236951, label = "particule de magie sauvage" },
                { itemID = 236950, label = "particule d'energie primordiale" },
            },
        },
    },
}