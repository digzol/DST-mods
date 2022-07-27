require "prefabutil"

local prefabs =
{
	"collapse_small",
}

local assets =
{
	Asset("ANIM", "anim/lamp_post2.zip"),
    Asset("ANIM", "anim/lamp_post2_city_build.zip"),   
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", true)
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    --inst:AddTag("structure")

	MakeObstaclePhysics(inst, .2)
	
    inst.AnimState:SetBank("lamp_post")
    inst.AnimState:SetBuild("lamp_post2_city_build")
    inst.AnimState:PlayAnimation("idle", true)

	inst.Light:SetRadius(10)
    inst.Light:SetIntensity(.6)
    inst.Light:SetFalloff(0.9)
    inst.Light:SetColour(197/255,197/255,10/255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoPeriodicTask(0.5 + math.random(), function(inst)
        if TheWorld.state.isnight then
            inst.Light:Enable(true)
        else
            inst.Light:Enable(true)
        end
    end)
    
    inst:AddComponent("inspectable")

    --[[inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)]]

    inst:ListenForEvent("onbuilt", onbuilt)
    --MakeSnowCovered(inst)

    --AddHauntableDropItemOrWork(inst)

    return inst
end

return Prefab("lamp_post", fn, assets, prefabs)