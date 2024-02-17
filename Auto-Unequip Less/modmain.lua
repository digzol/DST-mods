local _G = GLOBAL

local PARENT_MOD_NAME = " Auto-Unequip on 1%"
local PARENT_MOD_INDEX = _G.KnownModIndex:GetModActualName(PARENT_MOD_NAME)

local EXCLUDED_WORN_ITEMS =
{
    -- VANILLA IGNORE
    "wathgrithr_improvedhat",

    -- VANILLA UNREPAIRABLES
    "armor_bramble",
    "cookiecutterhat",
    
    -- MODDED UNREPAIRABLES
    "armor_rock",
    "gear_wings",
    "hat_marble",
    "hat_rock",
    "thorn_crown",
    "spartahelmut",
    "baronsuit",
    
    -- MODDED UNBREAKABLES
    "candlehat",
    "themask",
}

local EXCLUDED_HELD_ITEMS =
{
    -- VANILLA UNREPAIRABLES
    "axe",
    "batbat",
    "brush",
    "glasscutter",
    "golden_farm_hoe",
    "goldenaxe",
    "goldenpickaxe",
    "goldenshovel",
    "hammer",
    "lighter",
    "minifan",
    "malbatross_beak",
    "moonglassaxe",
    "multitool_axe_pickaxe",
    "nightstick",
    "nightsword",
    "oar",
    "oar_driftwood",
    "pitchfork",
    "ruins_bat",
    "spear",
    "spear_wathgrithr",
    "tentaclespike",
    "torch",
    "trident",
    "whip",
    
    -- VANILLA UNBREAKABLES
    "lantern",
    "premiumwateringcan",
    "wateringcan",
    "pocketwatch_weapon",
    
    -- MODDED UNREPAIRABLES
    "dark_axe",
    "dark_pickaxe",
    "fryingpan",
    "mace_sting",
    "sword_rock",
    
    -- MODDED UNBREAKABLES
    "bottlelantern",
    "broomstick",
    "elegantlantern",
    "opulentlantern",
    "scythe",
    "snowglobe",
}
if not PARENT_MOD_INDEX then
    print("WARNING: Auto-Unequip LESS requires "..PARENT_MOD_NAME.." in order to work. Disabling.")
    return
end

-- Weird workaround for "variable 'NONREFILLABLE' is not declared" when trying to do "if not _G.NONREFILLABLE ..."
local isTableFound = false
for k,_ in pairs(_G) do
    if (k == "NONREFILLABLE") then
        isTableFound = true
        break
    end
end

if not isTableFound then
    print("WARNING: Auto-Unequip LESS requires "..PARENT_MOD_NAME.." in order to work. Disabling.")
    return
end

local cfgFilter = _G.GetModConfigData("MAU_filter", PARENT_MOD_INDEX)
local cfgIgnoreHands = _G.GetModConfigData("MAU_hands", PARENT_MOD_INDEX)

if not cfgFilter then
    print("WARNING: Auto-Unequip LESS requires 'Ignore nonrefillable items' to be enabled in order to work. Disabling.")
    return
end

for _,v in ipairs(EXCLUDED_WORN_ITEMS) do
    _G.NONREFILLABLE[v] = true
end

if not cfgIgnoreHands then
    for _,v in ipairs(EXCLUDED_HELD_ITEMS) do
        _G.NONREFILLABLE[v] = true
    end
end
