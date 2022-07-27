--------------------------------------------------------------------------
-- Common Things to solve future errors --
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
local Ingredient = GLOBAL.Ingredient
local resolvefilepath = GLOBAL.resolvefilepath
local RECIPETABS = GLOBAL.RECIPETABS
local resolvefilepath = GLOBAL.resolvefilepath
local SpawnPrefab = GLOBAL.SpawnPrefab
local G = GLOBAL 
--------------------------------------------------------------------------
-- Mod dependencies -- 
modimport "scripts/hamletstrings"
--modimport "scripts/hamletrecipes" -- current disabled and can only be placed via console. TODO: edit recipes so they are craftable only in creative.
modimport "scripts/hamletassets"
modimport "scripts/hamletpostinits"
modimport "scripts/hamletpigbraizertweak"
-- modimport "turfs_rework/tile_rework_adder.lua"
-- modimport "turfs_rework/tile_rework.lua"
--------------------------------------------------------------------------
-- Prefabs --
PrefabFiles = {
	"rainforesttrees", 
	"rainforesttree_sapling",
	
	"clawpalmtrees",
	"clawpalmtree_sapling",
	
	"hamlet_placer",
	"hamlet_cones",
	
	"aloe",
	"flower_rainforest",
	
	"pugalisk_fountain",
	"nettle_plant",
	
	"tubertrees",
	"grass_tall2",
	
	--"new_turfs_hamlet",
	"lawnornaments",
	
	"smelter",
	"hamlet_walls",

	"mandrakehouse",
	"pig_ruins_torch",
	
	"lamp_post",
	"antcombhome",
	
	"rock_flippable",
	"smashingpot",
	
	"statuepigruinsant",
	"statuepigruinsidol",
	
	"statuepigruinspig",
	"ant_chest",
	
	"ant_honey_cache",
	"hamlet_pighouse1",
	
	"hamlet_pighouse2",
	"hamlet_pighouse3",
	
	"hamlet_pighouse4",
	"hamlet_pighouse5",
	
	"hamlet_pighouse6",
}
--------------------------------------------------------------------------
-- Minimap Icons -- 
--[[AddMinimapAtlas("minimap/minimap_data2.xml")
if not (GLOBAL.rawget(GLOBAL, "IsInFrontEnd") and GLOBAL.IsInFrontEnd()) then
    modimport "tile_rework_adder.lua"
    AddMinimap()
end]]
--------------------------------------------------------------------------
-- Turfs -- (disabled)
--[[
local MOD_GROUND_TURFS = {
	[GROUND.PIGRUINS] = "turf_pigruins",
	[GROUND.RAINFOREST] = "turf_rainforest",
	[GROUND.DEEPRAINFOREST] = "turf_deeprainforest",
	[GROUND.FIELDS] = "turf_fields",
	[GROUND.SUBURB] = "turf_moss",
	[GROUND.FOUNDATION] = "turf_foundation",
	-- [GROUND.CHECKEREDLAWN] = "turf_checkeredlawn",
	-- [GROUND.COBBLEROAD] = "turf_cobbleroad",
	[GROUND.GASJUNGLE] = "turf_gasjungle",
	[GROUND.ANTFLOOR] = "turf_antfloor",
	[GROUND.BATFLOOR] = "turf_batfloor",
	[GROUND.BATTLEGROUNDS] = "turf_battlegrounds",
	[GROUND.BOG] = "turf_bog",
	[GROUND.PLAINS] = "turf_plains",
	[GROUND.BEARDRUG] = "turf_beardrug",
}

local Terraformer = require("components/terraformer")
local OldTerraform = Terraformer.Terraform or function() return false end

local function SpawnTurf(turf, pt)
    if turf ~= nil then
        local loot = SpawnPrefab(turf)

        if loot.components.inventoryitem ~= nil then
            loot.components.inventoryitem:InheritMoisture(GLOBAL.TheWorld.state.wetness, GLOBAL.TheWorld.state.iswet)
        end

        loot.Transform:SetPosition(pt:Get())

        if loot.Physics ~= nil then
        local angle = math.random() * 2 * GLOBAL.PI
            loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))
        end
    end
end

function Terraformer:Terraform(pt, spawnturf)
    local Map = GLOBAL.TheWorld.Map

    if not Map:CanTerraformAtPoint(pt:Get()) then
        return false
    end

    local original_tile_type = Map:GetTileAtPoint(pt:Get())

    if OldTerraform(self, pt, spawnturf) then
        local turfPrefab = MOD_GROUND_TURFS[original_tile_type]

        if spawnturf and turfPrefab ~= nil then
        SpawnTurf(turfPrefab, pt)
        end

        return true
    end

    return false
end
]]
--------------------------------------------------------------------------
-- Modified containers.widgetsetup -- 
local containers = require "containers"

local params = {}

local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        containers_widgetsetup_base(container, prefab, data, ...)
    end
end
--------------------------------------------------------------------------
-- Fix for Chest UI (Ant Chest) --
params.ant_chest = 
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = GLOBAL.Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ant_chest.widget.slotpos, GLOBAL.Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end
--------------------------------------------------------------------------
-- Max Item Slots Fix --

for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
--------------------------------------------------------------------------