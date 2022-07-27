local spawnlists = require "spawnlists"

local function weighted_random_choice(choices)
	local weighted_total = 0
	for k, v in pairs(choices) do
		weighted_total = weighted_total + v.weight
	end
	
	local threshold = math.random() * weighted_total
	for choice, v in pairs(choices) do
		threshold = threshold - v.weight
		if threshold <= 0 then return choice end
	end
	
	return choices[#choices]
end

local function onSpawnTrigger(self, randomspawner)
	randomspawner:SpawnRandomOnAll()
end

local RandomSpawner = Class(function(self, inst)
	if not TheWorld.ismastersim then return inst end
	
	self.inst = inst
	self.spawnlists = spawnlists
	self.blacklist = {}
end)

function RandomSpawner:OnSave()
	return {
		blacklist = self.blacklist,
	}
end

function RandomSpawner:OnLoad(data)
	if data.blacklist ~= nil then
		self.blacklist = data.blacklist
	end
end

function RandomSpawner:Start()
	self.task = TheWorld:DoPeriodicTask(self.delay, onSpawnTrigger, 0, self)
	_G.c_announce("The random spawner has been started.")
end

function RandomSpawner:Stop()
	if self.task == nil then return end
	self.task:Cancel()
	self.task = nil
	_G.c_announce("The random spawner has been stopped.")
end

function RandomSpawner:SpawnRandomOnAll()
	for i,player in pairs(AllPlayers) do
		if player.components ~= nil and player.components.health ~= nil then
			local player_is_dead = player.components.health:IsDead() or player:HasTag("playerghost")
			if self.blacklist[player.userid] == nil and not player_is_dead then
				local result, spawn_attempts_remaining = nil, 10
				while result == nil and spawn_attempts_remaining > 0 do
					result = self:SpawnEntityOn(self:GetRandomEntity(), player)
					spawn_attempts_remaining = spawn_attempts_remaining - 1
				end
			end
		end
	end
end

function RandomSpawner:SpawnEntityOn(entity, player)
	player = player or ThePlayer
	
	local x, y, z = self:GetRandomPos(player)
	if x == nil then return end -- No valid placement around the player
	
	local newEnt = SpawnPrefab(entity)
	if newEnt == nil or newEnt.Transform == nil then return end

	newEnt.Transform:SetPosition(x, y, z)
	return newEnt
end

function RandomSpawner:DisableFor(player)
	self.blacklist[player.userid] = true
	ThePlayer.components.talker:Say("Disabled random spawns for ".. player.name, nil, true)
end

function RandomSpawner:EnableFor(player)
	if self.blacklist[player.userid] == nil then return end
	self.blacklist[player.userid] = nil
	ThePlayer.components.talker:Say("Re-enabled random spawns for ".. player.name, nil, true)
end

function RandomSpawner:GetRandomEntity()
	local category = weighted_random_choice(self.categories)
	local choice = weighted_random_choice(self.spawnlists[category])
	return choice
end

function RandomSpawner:GetRandomPos(player)
	local px, py, pz = player.Transform:GetWorldPosition()
	local is_water_tile_at_position = TheWorld.Map:IsOceanTileAtPoint(px, 0, pz)
	local attempts_remaining = 10
	while attempts_remaining > 0 do
		local x = px + math.random() * self.maxSpawnDistance * 2 - self.maxSpawnDistance
		local z = pz + math.random() * self.maxSpawnDistance * 2 - self.maxSpawnDistance
		
		local tile = TheWorld.Map:GetTileAtPoint(x, 0, z)
		local is_water_tile = TheWorld.Map:IsOceanTileAtPoint(x, 0, z)
		if tile ~= GROUND.INVALID and tile ~= GROUND.IMPASSABLE and is_water_tile_at_position == is_water_tile and (self.waterSpawns or not is_water_tile) then
			return x, 0, z -- Tile is valid, traversable, the same type (land or water) under the player, and is not water if configured to be disallowed
		end
		
		attempts_remaining = attempts_remaining - 1
	end
end

-- E.g. GetRandomSpawner():DebugSpawnGroup("food")
function RandomSpawner:DebugSpawnGroup(groupid)
	local spawnlist = self.spawnlists[groupid]
	if spawnlist == nil then
		print("Invalid group: '".. groupid .."'")
		return
	end
	
	local spawnCount,spawnsExpected = 0, 0
	local configMaxSpawnDistance = self.maxSpawnDistance
	self.maxSpawnDistance = 10
	
	for ent in pairs(spawnlist) do
		if self:SpawnEntityOn(ent, ThePlayer) ~= nil then
			spawnCount = spawnCount + 1
		end
		spawnsExpected = spawnsExpected + 1
	end
	
	self.maxSpawnDistance = configMaxSpawnDistance
	
	print("Spawned ".. spawnCount .."/".. spawnsExpected .." entities for group '".. groupid .."'")
end

return RandomSpawner