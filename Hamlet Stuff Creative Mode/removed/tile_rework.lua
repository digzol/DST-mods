------------------------------------------------
local sound_run = "dontstarve/movement/run_grass"
local sound_walk = "dontstarve/movement/walk_grass"
local sound_snow = "dontstarve/movement/run_ice"
local sound_mud = "dontstarve/movement/run_mud"
local sound_roadrun = "dontstarve/movement/run_marble"
local sound_roadwalk = "dontstarve/movement/run_marble"
------------------------------------------------
function TurfInfo()
local TurfRework = { -- Currently This turfs has a bug that make the game crash.
COBBLEROAD = {
	numid = 87,
	layer = 35,
	specs = {
		name = "stoneroad",
		noise_texture = "levels/textures/Ground_noise_cobbleroad.tex",
		runsound = sound_roadrun,
		walksound = sound_roadwalk,
		snowsound = sound_snow,
		mudsound = sound_mud,
		},
	mgt = "levels/textures/mini_brickroad_noise.tex",
	turf = { { "turf_cobbleroad" } },
	isfloor = true
},
CHECKEREDLAWN = {
	numid = 86,
	layer = 32,
	specs = {
		name = "pebble",
		noise_texture = "levels/textures/ground_noise_checkeredlawn.tex",
		runsound = sound_run,
		walksound = sound_walk,
		snowsound = sound_snow,
		mudsound = sound_mud,
		},
	mgt = "levels/textures/mini_grasslawn_noise.tex",
	turf = { { "turf_checkeredlawn" } }
	}
}
    return TurfRework
end
