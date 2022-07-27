local assets =
{
    Asset("ANIM", "anim/ant_honey_cache.zip"),
    -- Asset("MINIMAP_IMAGE", "ant_house"),
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("full_hit")
	inst.AnimState:PushAnimation("full")
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("full")
	inst.AnimState:PushAnimation("full")
end

local function fn(Sim)
    local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	local light = inst.entity:AddLight()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "ant_chest.png" )

    inst.AnimState:SetBuild("ant_honey_cache")    
    inst.AnimState:SetBank("honey_cache")
    inst.AnimState:PlayAnimation("full")
    
    MakeObstaclePhysics(inst, 1)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	
	--inst:AddComponent("hauntable")
    --inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	--[[inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 
	inst.components.workable:SetWorkLeft(3)]]
	
	light:SetFalloff(1)
    light:SetIntensity(.5)
    light:SetRadius(1)
    light:Enable(true)
    light:SetColour(185/255, 185/255, 20/255)
    inst.lightson = true
	
    return inst
end

return Prefab("ant_honey_cache", fn, assets, prefabs)


