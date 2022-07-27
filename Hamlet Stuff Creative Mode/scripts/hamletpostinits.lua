local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
local Ingredient = GLOBAL.Ingredient
local resolvefilepath = GLOBAL.resolvefilepath
local RECIPETABS = GLOBAL.RECIPETABS
local resolvefilepath = GLOBAL.resolvefilepath
local SpawnPrefab = GLOBAL.SpawnPrefab
local G = GLOBAL 

AddComponentPostInit( -- Speedboost for Cobbleroad Turf. 
    "locomotor",
    function(inst)
        local old = inst.UpdateGroundSpeedMultiplier
        inst.UpdateGroundSpeedMultiplier = function(self)
            old(self)
            if
                self.wasoncreep == false and self:FasterOnRoad() and
                    G.TheWorld.Map:GetTileAtPoint(self.inst.Transform:GetWorldPosition()) == GROUND.COBBLEROAD
             then
                self.groundspeedmultiplier = self.fastmultiplier
            end
        end
    end
)

AddPrefabPostInit("wall_pig_ruins_item", function(inst)	 
	if inst.components.inventoryitem ~= nil then 
	inst.components.inventoryitem.imagename = "wall_pigruins"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/wall_pigruins.xml"
	end 
end)

AddPrefabPostInit("turf_antfloor", function(inst)
	if inst.components.inventoryitem ~= nil then 
	inst.components.inventoryitem.imagename = "turf01-13"
	inst.components.inventoryitem.atlasname = "images/turfs/turf01-13.xml"
	end
end)

AddPrefabPostInit("turf_batfloor", function(inst)
	if inst.components.inventoryitem ~= nil then 
	inst.components.inventoryitem.imagename = "turf01-12"
	inst.components.inventoryitem.atlasname = "images/turfs/turf01-12.xml"
	end
end)

AddPrefabPostInit("turf_battlegrounds", function(inst)
	if inst.components.inventoryitem ~= nil then 
	inst.components.inventoryitem.imagename = "turf01-11"
	inst.components.inventoryitem.atlasname = "images/turfs/turf01-11.xml"
	end
end)

AddPrefabPostInit("turf_plains", function(inst)
	if inst.components.inventoryitem ~= nil then 
	inst.components.inventoryitem.imagename = "turf01-10"
	inst.components.inventoryitem.atlasname = "images/turfs/turf01-10.xml"
	end
end)

AddPrefabPostInit("turf_bog", function(inst)
	if inst.components.inventoryitem ~= nil then 
	inst.components.inventoryitem.imagename = "turf01-9"
	inst.components.inventoryitem.atlasname = "images/turfs/turf01-9.xml"
	end
end)

AddPrefabPostInit("turf_beardrug", function(inst)
	if inst.components.inventoryitem ~= nil then
	inst.components.inventoryitem.imagename = "turf01-14"
	inst.components.inventoryitem.atlasname = "images/turfs/turf01-14.xml"
	end
end)