------------------------------------------------
if not (GLOBAL.rawget(GLOBAL, "IsInFrontEnd") and GLOBAL.IsInFrontEnd()) then
    modimport "tile_rework_adder.lua"
    AddTiles()
end
------------------------------------------------
modimport("tile_adder.lua")

local sound_run = "dontstarve/movement/run_grass"
local sound_walk = "dontstarve/movement/walk_grass"
local sound_snow = "dontstarve/movement/run_ice"
local sound_mud = "dontstarve/movement/run_mud"
local sound_roadrun = "dontstarve/movement/run_marble"
local sound_roadwalk = "dontstarve/movement/run_marble"
------------------------------------------------
AddTile(
	"PIGRUINS", 
	79, 
	"blocky", 
	{ 
		noise_texture = "levels/textures/ground_ruins_slab.tex", 
		runsound = sound_roadrun, 
		walksound = sound_roadwalk, 
		snowsound = sound_snow, 
		mudsound = sound_mud, 
	}, 
	{ noise_texture = "levels/textures/mini_ruins_slab.tex" }
) 
AddTile(
	"RAINFOREST", 
	81, 
	"rain_forest", 
	{
		noise_texture = "levels/textures/Ground_noise_rainforest.tex",
		runsound = sound_run, 
		walksound = sound_walk, 
		snowsound = sound_snow, 
		mudsound = sound_mud, 
	}, 
	{ noise_texture = "levels/textures/mini_noise_rainforest.tex" }
)
AddTile(
	"DEEPRAINFOREST",
	82,
	"jungle_deep",
	{
		noise_texture = "levels/textures/Ground_noise_jungle_deep.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_jungle_deep.tex"}
)
AddTile(
	"FIELDS",
	83,
	"yellowgrass",
	{
		noise_texture = "levels/textures/noise_farmland.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_farmland.tex"}
)
AddTile(
	"SUBURB",
	84,
	"desert_dirt",
	{
		noise_texture = "levels/textures/noise_mossy_blossom.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_mossy_blossom.tex"}
)
AddTile(
	"FOUNDATION",
	85,
	"blocky",
	{
		noise_texture = "levels/textures/noise_ruinsbrick_scaled.tex",
		runsound = sound_roadrun,
		walksound = sound_roadwalk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_grass_noise.tex"}
)
--[[ -- Currently Bugged turfs, look tile_rework.lua. for the new method.
AddTile(
	"CHECKEREDLAWN",
	86,
	"pebble",
	{
		noise_texture = "levels/textures/ground_noise_checkeredlawn.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_grasslawn_noise.tex"}
)

AddTile(
	"COBBLEROAD",
	87,
	"stoneroad",
	{
		noise_texture = "levels/textures/Ground_noise_cobbleroad.tex",
		runsound = sound_roadrun,
		walksound = sound_roadwalk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_brickroad_noise.tex"}
)
]]--
AddTile(
	"GASJUNGLE",
	88,
	"jungle_deep",
	{
		noise_texture = "levels/textures/ground_noise_gas.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_gasbiome_noise.tex"}
)
AddTile(
	"ANTFLOOR",
	89,
	"cave",
	{
		noise_texture = "levels/textures/ground_noise_antfloor.tex",
		runsound = sound_roadrun,
		walksound = sound_roadwalk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_antfloor.tex"}
)
AddTile(
	"BATFLOOR",
	90,
	"cave",
	{
		noise_texture = "levels/textures/ground_noise_batfloor.tex",
		runsound = sound_roadrun,
		walksound = sound_roadwalk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_batfloor.tex"}
)
AddTile(
	"BATTLEGROUNDS",
	91,
	"city_grass",
	{
		noise_texture = "levels/textures/ground_noise_battlegrounds.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_battlegrounds.tex"}
)
AddTile(
	"BOG",
	92,
	"cave",
	{
		noise_texture = "levels/textures/ground_noise_bog.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_bog.tex"}
)
AddTile(
	"PLAINS",
	93,
	"jungle",
	{
		noise_texture = "levels/textures/ground_noise_plains.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_plains.tex"}
)
AddTile(
	"BEARDRUG",
	94,
	"carpet",
	{
		noise_texture = "levels/textures/Ground_beard_hair.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
	},
	{ noise_texture = "levels/textures/mini_noise_battlegrounds.tex"}
)
------------------------------------------------------------------------------------------------
-- Our Turfs Order. -- 
ChangeTileTypeRenderOrder(GLOBAL.GROUND.SUBURB, GLOBAL.GROUND.DIRT) -- 1
ChangeTileTypeRenderOrder(GLOBAL.GROUND.FIELDS, GLOBAL.GROUND.DIRT) -- 2
ChangeTileTypeRenderOrder(GLOBAL.GROUND.BATTLEGROUNDS, GLOBAL.GROUND.DIRT) -- 3
ChangeTileTypeRenderOrder(GLOBAL.GROUND.RAINFOREST, GLOBAL.GROUND.DIRT) -- 4
ChangeTileTypeRenderOrder(GLOBAL.GROUND.DEEPRAINFOREST, GLOBAL.GROUND.DIRT) -- 5
ChangeTileTypeRenderOrder(GLOBAL.GROUND.GASJUNGLE, GLOBAL.GROUND.DIRT) -- 6
ChangeTileTypeRenderOrder(GLOBAL.GROUND.PLAINS, GLOBAL.GROUND.DIRT) -- 7
ChangeTileTypeRenderOrder(GLOBAL.GROUND.BOG, GLOBAL.GROUND.DIRT) -- 8
ChangeTileTypeRenderOrder(GLOBAL.GROUND.ANTFLOOR, GLOBAL.GROUND.DIRT) -- 9
ChangeTileTypeRenderOrder(GLOBAL.GROUND.BATFLOOR, GLOBAL.GROUND.DIRT) -- 10
ChangeTileTypeRenderOrder(GLOBAL.GROUND.FOUNDATION, GLOBAL.GROUND.DIRT) -- 11
ChangeTileTypeRenderOrder(GLOBAL.GROUND.PIGRUINS, GLOBAL.GROUND.DIRT) -- 12
-- ChangeTileTypeRenderOrder(GLOBAL.GROUND.CHECKEREDLAWN, GLOBAL.GROUND.DIRT) -- 13 Actually Crashing The game.
-- ChangeTileTypeRenderOrder(GLOBAL.GROUND.COBBLEROAD, GLOBAL.GROUND.DIRT) -- 14
------------------------------------------------------------------------------------------------
-- Base Game Turfs under ours. --
ChangeTileTypeRenderOrder(GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.PLAINS)
ChangeTileTypeRenderOrder(GLOBAL.GROUND.DECIDUOUS, GLOBAL.GROUND.SUBURB)
ChangeTileTypeRenderOrder(GLOBAL.GROUND.FOUNDATION, GLOBAL.GROUND.FIELDS)
ChangeTileTypeRenderOrder(GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CHECKER)
ChangeTileTypeRenderOrder(GLOBAL.GROUND.BEARDRUG, GLOBAL.GROUND.PIGRUINS)