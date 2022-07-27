local assets =
{
    Asset("ANIM", "anim/ant_house.zip"),
    -- Asset("MINIMAP_IMAGE", "ant_house"),
}

local prefabs =
{
    --"waterdrop",
    --"lifeplant",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("idle")
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
end

local function fn(Sim)
    local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	local light = inst.entity:AddLight()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "ant_house.png" )

    inst.AnimState:SetBuild("ant_house")    
    inst.AnimState:SetBank("ant_house")
    inst.AnimState:PlayAnimation("idle", true)
    
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
	inst.components.workable:SetWorkLeft(5)]]
	
	light:SetFalloff(1)
    light:SetIntensity(.5)
    light:SetRadius(1)
    light:Enable(true)
    light:SetColour(185/255, 185/255, 20/255)
    inst.lightson = true
	
    return inst
end

return Prefab("antcombhome", fn, assets, prefabs)


