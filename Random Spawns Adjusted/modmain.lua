modimport "lib_ver.lua"

local function WorldPostInit(world)
	if not world.components.randomspawner then
		world:AddComponent("randomspawner")
	end
end

local function RandomSpawnerPostInit(inst)
	inst.delay = GetModConfigData("SPAWN_DELAY")
	inst.waterSpawns = GetModConfigData("ALLOW_WATER")
	inst.maxSpawnDistance = GetModConfigData("MAX_SPAWN_DISTANCE")
	inst.categories = {
		["armor"] = { weight = GetModConfigData("ARMOR_CHANCE") },
		["blueprints"] = { weight = GetModConfigData("BLUEPRINT_CHANCE") },
		["bosses"] = { weight = GetModConfigData("BOSS_CHANCE") },
		["clothing"] = { weight = GetModConfigData("CLOTHING_CHANCE") },
		["fx"] = { weight = GetModConfigData("EFFECT_CHANCE") },
		["food"] = { weight = GetModConfigData("FOOD_CHANCE") },
		["healing"] = { weight = GetModConfigData("HEALING_CHANCE") },
		["material"] = { weight = GetModConfigData("MATERIAL_CHANCE") },
		["mobs"] = { weight = GetModConfigData("MOB_CHANCE") },
		["structures"] = { weight = GetModConfigData("STRUCTURE_CHANCE") },
		["tools"] = { weight = GetModConfigData("TOOL_CHANCE") },
		["trinkets"] = { weight = GetModConfigData("TRINKET_CHANCE") },
		["weapons"] = { weight = GetModConfigData("WEAPON_CHANCE") },
		["misc"] = { weight = GetModConfigData("MISC_CHANCE") },
	}
	
	if GetModConfigData("AUTO_START") then
		inst:Start()
	end
end

AddWorldPostInit(WorldPostInit)
AddComponentPostInit("randomspawner", RandomSpawnerPostInit)

GLOBAL.GetRandomSpawner = function()
	if TheWorld.components.randomspawner then
		return TheWorld.components.randomspawner
	end
end