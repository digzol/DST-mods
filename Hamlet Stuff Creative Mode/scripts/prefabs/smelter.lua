require "prefabutil"

--local cooking = require("smelting")

local assets=
{
	Asset("ANIM", "anim/smelter.zip"),
	--Asset("ANIM", "anim/cook_pot_food.zip"),
	Asset("IMAGE", "images/inventoryimages/inventoryimages2.tex"),
	Asset("ATLAS", "images/inventoryimages/inventoryimages2.xml"),
}

local prefabs = {"collapse_small"}
--[[
for k,v in pairs(cooking.recipes.cookpot) do
	table.insert(prefabs, v.name)
end
]]


local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit_empty")
		else
			inst.AnimState:PushAnimation("idle_empty")
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle_empty")
	--inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/crafted/smelter/build")
end
 
local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "smelter.tex" )
	
    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
	inst.Light:SetRadius(.6)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(235/255,62/255,12/255)
    --inst.Light:SetColour(1,0,0)
    
    --inst:AddTag("structure")
    MakeObstaclePhysics(inst, .5)
    
    inst.AnimState:SetBank("smelter")
    inst.AnimState:SetBuild("smelter")
    inst.AnimState:PlayAnimation("idle_empty")


    inst:AddComponent("inspectable")

    --inst:AddComponent("lootdropper")
    --inst:AddComponent("workable")
    --inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    --inst.components.workable:SetWorkLeft(4)
	--inst.components.workable:SetOnFinishCallback(onhammered)
	--inst.components.workable:SetOnWorkCallback(onhit)

	MakeSnowCovered(inst, .01)    
	inst:ListenForEvent( "onbuilt", onbuilt)

	--MakeMediumBurnable(inst, nil, nil, true)
	--MakeSmallPropagator(inst)

    return inst
end

return Prefab("smelter", fn, assets, prefabs)