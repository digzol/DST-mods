local assets =
{
    Asset("ANIM", "anim/python_fountain.zip"), 
	Asset("ANIM", "anim/grass_tall.zip"),
	Asset("SOUND", "sound/common.fsb"),
	Asset("MINIMAP_IMAGE", "grass"),
}

local prefabs =
{
    --"waterdrop",
    --"lifeplant",
	"dug_grass",
}

local function dig_up(inst, chopper)
	inst.components.lootdropper:SpawnLootPrefab("dug_grass")
	inst:Remove()
end 

local function fn(Sim)
    local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    inst.AnimState:SetBuild("grass_tall")    
    inst.AnimState:SetBank("grass_tall")
    inst.AnimState:PlayAnimation("idle", true)
    
	inst:AddTag("watersource")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")
    
    --MakeObstaclePhysics(inst, 2)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("grass.png")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	
	--inst:AddComponent("hauntable")
    --inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	--[[inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig_up)
	inst.components.workable:SetWorkLeft(2)]]
	
    return inst
end

return Prefab("grass_tall2", fn, assets, prefabs)


