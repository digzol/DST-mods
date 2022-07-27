local assets =
{
    Asset("ANIM", "anim/sprinkler.zip"),
	Asset("ANIM", "anim/sprinkler_meter.zip"),
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("idle")
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle_off")
end

local function fn(Sim)
    local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    inst.AnimState:SetBuild("sprinkler")    
    inst.AnimState:SetBank("sprinkler")
    inst.AnimState:PlayAnimation("idle_off")
    
	inst:AddTag("watersource")
    
    MakeObstaclePhysics(inst, 1)
	
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("sprinkler.png")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	--[[inst:AddComponent("lootdropper")
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 
	inst.components.workable:SetWorkLeft(4)]]
	
    return inst
end

return Prefab("sprinkler", fn, assets, prefabs)


