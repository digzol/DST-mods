-- Actually new tile_adder for the 2 bugged turfs (Lawn and Cobbleroad) I think they're working now. 
local _G = GLOBAL
local require = GLOBAL.require
local Asset = _G.Asset
local error = _G.error
local unpack = _G.unpack
local GROUND = _G.GROUND
local GROUND_NAMES = _G.GROUND_NAMES
local GROUND_FLOORING = _G.GROUND_FLOORING
local resolvefilepath = _G.resolvefilepath
require "map/terrain"
local tiledefs = require "worldtiledefs"
modimport "tile_rework.lua"

local newTilesProperties = TurfInfo() 
local minStartID = 33 

print("Strating Tileadder")

local function GroundTextures(name)
    return "levels/textures/noise_" .. name .. ".tex"
end
local function MiniGroundTextures(name)
    return "levels/textures/mini_noise_" .. name .. ".tex"
end
local function GroundImage(name)
    return "levels/tiles/" .. name .. ".tex"
end
local function GroundAtlas(name)
    return "levels/tiles/" .. name .. ".xml"
end

function AddTiles()
    for tilename, data in pairs(newTilesProperties) do
        _G.assert(_G.type(tilename) == "string", "Name should be a string parameter")
        _G.assert(_G.type(data.specs) == "table", "Specs should be a table parameter")

        local mapspecs = data.specs
        local numid = (_G.type(data.numid) == "number" and data.numid > minStartID) and data.numid or minStartID
        local layer = _G.type(data.layer) == "number" and data.layer or nil
        if layer and (layer < 0 or layer >= 255) then
            return error(("Layer level shoud be in range 1..255, now it is %d"):format(layer))
        end

        local chk = true
        while chk do
            chk = false
            for _, val2 in pairs(tiledefs.ground) do
                if val2[1] == numid then
                    print("[tileadder]", numid, "is reserved, incrementing...")
                    numid = numid + 1
                    chk = true
                end
            end
        end

        if numid >= GROUND.UNDERGROUND then
            return error(("Numerical id %d is out of limits"):format(numid, GROUND.UNDERGROUND), 3)
        end

        print("lowest founded value:", numid)
        ------------------------------------------------------
        GROUND[tilename:upper()] = numid
        GROUND_NAMES[numid] = tilename
        GROUND_FLOORING[numid] = data.isfloor

        mapspecs = mapspecs or {}

        local tileSpecDefault = {
            name = "carpet",
            noise_texture = GroundTextures(tilename:lower()),
            runsound = "dontstarve/movement/run_dirt",
            walksound = "dontstarve/movement/walk_dirt",
            snowsound = "dontstarve/movement/run_ice",
            mudsound = "dontstarve/movement/run_mud",
			sound_roadrun = "dontstarve/movement/run_marble",
			sound_roadwalk = "dontstarve/movement/run_marble",
            flashpoint_modifier = 0
        }

        local realMapspecs = {}

        for k, spec in pairs(mapspecs) do
            realMapspecs[k] = spec
        end

        for k, default in pairs(tileSpecDefault) do
           
            if realMapspecs[k] == nil then
                realMapspecs[k] = default
            end
        end

        if layer then
            table.insert(tiledefs.ground, layer, { numid, realMapspecs })
        else
            table.insert(tiledefs.ground, { numid, realMapspecs })
        end

        table.insert(tiledefs.assets, Asset("IMAGE", realMapspecs.noise_texture))
        table.insert(tiledefs.assets, Asset("IMAGE", GroundImage(realMapspecs.name)))
        table.insert(tiledefs.assets, Asset("FILE", GroundAtlas(realMapspecs.name)))
        print("[tileadder]", tilename, "added!")
    end
end

function AddMinimap()
    local addedTilesTurfInfo = {}
    local minimapGroundProperties = {}

    for tilename, data in pairs(newTilesProperties) do
        local groundID
        for k, v in pairs(GROUND_NAMES) do
            
            if v == tilename then
                groundID = k
                break
            end
        end
        local mapspecs = data.specs or {}
        local name = mapspecs.name or tilename
        local mgt = data.mgt or MiniGroundTextures(name)
        table.insert(Assets, Asset("IMAGE", mapspecs.noise_texture or GroundTextures(name)))
        table.insert(Assets, Asset("IMAGE", mgt))
        table.insert(Assets, Asset("IMAGE", GroundImage(name)))
        table.insert(Assets, Asset("FILE", GroundAtlas(name)))
        table.insert(minimapGroundProperties, { groundID, { name = "map_edge", noise_texture = mgt } })

        if data.turf then
            _G.assert(_G.type(data.turf) == "table")
            addedTilesTurfInfo[groundID] = data.turf
        end
    end
	
    AddPrefabPostInit(
            "minimap",
            function(inst)
                for _, data in pairs(minimapGroundProperties) do
                    local tile_type, layer_properties = unpack(data)
                    print(layer_properties.name, GroundAtlas(layer_properties.name))
                    local handle = _G.MapLayerManager:CreateRenderLayer(
                            tile_type,
                            resolvefilepath(GroundAtlas(layer_properties.name)),
                            resolvefilepath(GroundImage(layer_properties.name)),
                            resolvefilepath(layer_properties.noise_texture)
                    )
                    inst.MiniMap:AddRenderLayer(handle)
                end
            end
    )

    AddComponentPostInit(
            "terraformer",
            function(self)
                local _Terraform = self.Terraform
                self.Terraform = function(self, pt, spawnturf)
                    local tile = GLOBAL.TheWorld.Map:GetTileAtPoint(pt:Get())
                    if _Terraform(self, pt, spawnturf) then
                        if addedTilesTurfInfo[tile] then
                            for k, lootinfo in pairs(addedTilesTurfInfo[tile]) do
                                local min = lootinfo[2] or 1
                                local max = lootinfo[3] or min
                                for i = 1, math.random(min, max) do
                                    local loot = GLOBAL.SpawnPrefab(lootinfo[1])
                                    loot.Transform:SetPosition(pt:Get())
                                    if loot.Physics ~= nil then
                                        local angle = math.random() * 2 * GLOBAL.PI
                                        loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))
                                    end
                                end
                            end
                        end
                    else
                        return false
                    end
                    return true
                end
            end
    )
end
