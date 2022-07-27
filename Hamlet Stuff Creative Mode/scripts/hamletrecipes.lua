local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
local Ingredient = GLOBAL.Ingredient
local resolvefilepath = GLOBAL.resolvefilepath
local RECIPETABS = GLOBAL.RECIPETABS
local resolvefilepath = GLOBAL.resolvefilepath
local SpawnPrefab = GLOBAL.SpawnPrefab
local G = GLOBAL

modimport "scripts/hamletassets"

-- Recipes (Trees) -- 
local burrrecipe = AddRecipe("rainforesttree_cone", {Ingredient("pinecone", 1)},
RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, 1, nil, 
"images/inventoryimages/rainforesttree_cone.xml", "rainforesttree_cone.tex")

local clawlingrecipe = AddRecipe("clawpalmtree_cone", {Ingredient("acorn", 1)},
RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, 1, nil, 
"images/inventoryimages/clawpalmtree_cone.xml", "clawpalmtree_cone.tex")

local pigwallrecipe = AddRecipe("wall_pig_ruins_item", {Ingredient("cutstone", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 6, nil, 
"images/inventoryimages/wall_pigruins.xml", "wall_pigruins.tex")

-- Recipes (Structures) -- 
local aloerecipe = AddRecipe("aloe_planted", {Ingredient("succulent_picked", 1)}, RECIPETABS.FARM, TECH.SCIENCE_TWO, 
		"aloe_planted_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/inventoryimages2.xml",
		"aloe.tex")
		
local GLZ = GetModConfigData("GLZ")
if GLZ then
local frainforestrecipe = AddRecipe("flower_rainforest", {Ingredient("foliage", 1)}, RECIPETABS.FARM, TECH.SCIENCE_TWO, 
		"flower_rainforest_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/rainforestflower.xml",
		"rainforestflower.tex")
else
local frainforestrecipe2 = AddRecipe("flower_rainforest", {Ingredient("petals", 1)}, RECIPETABS.FARM, TECH.SCIENCE_TWO, 
		"flower_rainforest_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/rainforestflower.xml",
		"rainforestflower.tex")
end 
		
local brazierrecipe = AddRecipe("pig_ruins_torch", {Ingredient("cutstone", 2),  Ingredient("charcoal", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"ruins_pig_torch_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/brazier.xml",
		"brazier.tex")
		

local pfountainrecipe = AddRecipe("pugalisk_fountain", {Ingredient("cutstone", 4),  Ingredient("rocks", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"pugalisk_fountain_placer",
		4,
		nil,
		nil,
		nil,
		"images/inventoryimages/pugaliskfountain.xml",
		"pugaliskfountain.tex")
		

local lpostrecipe = AddRecipe("lamp_post", {Ingredient("cutstone", 2),  Ingredient("torch", 1)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"piglamp_post_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/lamppost.xml",
		"lamppost.tex")
		
		
local nettlerecipe = AddRecipe("nettle", {Ingredient("cutlichen", 1)}, RECIPETABS.FARM, TECH.SCIENCE_TWO,
		"nettle_plant_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/plantnettle.xml",
		"plantnettle.tex")
		
		
local tuberrecipe = AddRecipe("tubertree_short", {Ingredient("log", 2), Ingredient("poop", 2)}, RECIPETABS.REFINE, TECH.SCIENCE_TWO,
		"tubertree_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/inventoryimages2.xml",
		"tuber_crop.tex")
	
	
local tallgrassrecipe = AddRecipe("grass_tall2", {Ingredient("dug_grass", 1), Ingredient("poop", 2)}, RECIPETABS.REFINE, TECH.SCIENCE_TWO,
		"grass_tall_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/inventoryimages2.xml",
		"dug_grass.tex")
		

local smelterrecipe = AddRecipe("smelter", {Ingredient("cutstone", 2), Ingredient("goldnugget", 2), Ingredient("gears", 1)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"smelter_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/inventoryimages2.xml",
		"smelter.tex")
		
		
local lamprecipe = AddRecipe("mandrakehouse", {Ingredient("mandrake", 1), Ingredient("boards", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"mandrakehouse_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/drakehouse.xml",
		"drakehouse.tex")
		
		
local antcombrecipe = AddRecipe("antcombhome", {Ingredient("honey", 4), Ingredient("boards", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"antcombhome_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/antcombhome.xml",
		"antcombhome.tex")	


local antchestrecipe = AddRecipe("ant_chest", {Ingredient("honey", 2), Ingredient("boards", 3)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"antchest_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/antchest.xml",
		"antchest.tex")	


local cacherecipe = AddRecipe("ant_honey_cache", {Ingredient("honeycomb", 1), Ingredient("boards", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"antcache_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/cache.xml",
		"cache.tex")		
		

local potrecipe = AddRecipe("smashingpot", {Ingredient("cutstone", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"smashingpot_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/smashingpot.xml",
		"smashingpot.tex")	


local statuepig1recipe = AddRecipe("pigstatue_ant", {Ingredient("cutstone", 2), Ingredient("goldnugget", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"statuepig1_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/statuepig1.xml",
		"statuepig1.tex")		
		
		
local statuepig2recipe = AddRecipe("pigstatue_idol", {Ingredient("cutstone", 2), Ingredient("goldnugget", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"statuepig2_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/statuepig2.xml",
		"statuepig2.tex")			
		
		
local statuepig3recipe = AddRecipe("pigstatue_pig", {Ingredient("cutstone", 2), Ingredient("goldnugget", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"statuepig3_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/statuepig3.xml",
		"statuepig3.tex")	


local flippablerecipe = AddRecipe("rock_flippable", {Ingredient("rocks", 3)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"flippable_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/flippable.xml",
		"flippable.tex")	
		
		
-- Recipes (Lawn Decorations) -- 
local lawn1recipe = AddRecipe("lawnornament_1", {Ingredient("cutgrass", 3), Ingredient("log", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"lawn1_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/lawn1.xml",
		"lawn1.tex")
		
local lawn2recipe = AddRecipe("lawnornament_2", {Ingredient("cutgrass", 3), Ingredient("log", 2) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"lawn2_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/lawn2.xml",
		"lawn2.tex")

local lawn3recipe = AddRecipe("lawnornament_3", {Ingredient("cutgrass", 3), Ingredient("log", 2) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"lawn3_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/lawn3.xml",
		"lawn3.tex")
		
local lawn4recipe = AddRecipe("lawnornament_4", {Ingredient("cutgrass", 3), Ingredient("log", 2) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"lawn4_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/lawn4.xml",
		"lawn4.tex")
		
local lawn5recipe = AddRecipe("lawnornament_5", {Ingredient("cutgrass", 3), Ingredient("log", 2) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"lawn5_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/lawn5.xml",
		"lawn5.tex")
		
local lawn6recipe = AddRecipe("lawnornament_6", {Ingredient("petals", 2), Ingredient("berries", 1), Ingredient("marble", 1) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"lawn6_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/lawn6.xml",
		"lawn6.tex")
		
local lawn7recipe = AddRecipe("lawnornament_7", {Ingredient("petals", 2), Ingredient("marble", 1) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
		"lawn7_placer",
		2,
		nil,
		nil,
		nil,
		"images/inventoryimages/lawn7.xml",
		"lawn7.tex")
		
-- Recipes (Pig House) --
local house1recipe = AddRecipe("hamlet_house1", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("pigskin", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, 
		"hamlet_house1_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/house1.xml",
		"house1.tex")
		
local house2recipe = AddRecipe("hamlet_house2", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("pigskin", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, 
		"hamlet_house2_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/house2.xml",
		"house2.tex")
		
local house3recipe = AddRecipe("hamlet_house3", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("pigskin", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, 
		"hamlet_house3_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/house3.xml",
		"house3.tex")
		
local house4recipe = AddRecipe("hamlet_house4", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("pigskin", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, 
		"hamlet_house4_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/house4.xml",
		"house4.tex")
		
local house5recipe = AddRecipe("hamlet_house5", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("pigskin", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, 
		"hamlet_house5_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/house5.xml",
		"house5.tex")

local house6recipe = AddRecipe("hamlet_house6", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("pigskin", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, 
		"hamlet_house6_placer",
		1,
		nil,
		nil,
		nil,
		"images/inventoryimages/house6.xml",
		"house6.tex")		
		
-- Recipes (Turfs) --		
local turf1recipe = AddRecipe("turf_fields", {Ingredient("turf_savanna", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_fields.tex")

local turf2recipe = AddRecipe("turf_moss", {Ingredient("turf_forest", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_moss.tex")

local turf3recipe = AddRecipe("turf_foundation", {Ingredient("turf_rocky", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_foundation.tex")

local turf4recipe = AddRecipe("turf_cobbleroad", {Ingredient("turf_road", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_cobbleroad.tex")

local turf5recipe = AddRecipe("turf_gasjungle", {Ingredient("turf_fungus_red", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_gasjungle.tex")

local turf6recipe = AddRecipe("turf_checkeredlawn", {Ingredient("cutgrass", 1), Ingredient("nitre", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_checkeredlawn.tex")

local turf7recipe = AddRecipe("turf_deeprainforest", {Ingredient("turf_forest", 1), Ingredient("cutgrass", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_deeprainforest.tex")

local turf8recipe = AddRecipe("turf_rainforest", {Ingredient("turf_grass", 1), Ingredient("cutgrass", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_rainforest.tex")

local turf9recipe = AddRecipe("turf_pigruins", {Ingredient("turf_rocky", 1), Ingredient("rocks", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/inventoryimages/inventoryimages2.xml", "turf_pigruins.tex")

local turf10recipe = AddRecipe("turf_antfloor", {Ingredient("turf_mud", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/turfs/turf01-13.xml", "turf01-13.tex")

local turf11recipe = AddRecipe("turf_batfloor", {Ingredient("turf_underrock", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/turfs/turf01-12.xml", "turf01-12.tex")

local turf12recipe = AddRecipe("turf_battlegrounds", {Ingredient("turf_deciduous", 1), Ingredient("cutgrass", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/turfs/turf01-11.xml", "turf01-11.tex")

local turf13recipe = AddRecipe("turf_bog", {Ingredient("turf_deciduous", 1), Ingredient("turf_mud", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/turfs/turf01-9.xml", "turf01-9.tex")

local turf14recipe = AddRecipe("turf_plains", {Ingredient("turf_grass", 1), Ingredient("turf_savanna", 1)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/turfs/turf01-10.xml", "turf01-10.tex")

local turf15recipe = AddRecipe("turf_beardrug", {Ingredient("beardhair", 2), Ingredient("cutgrass", 2)},
RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil,
"images/turfs/turf01-14.xml", "turf01-14.tex")