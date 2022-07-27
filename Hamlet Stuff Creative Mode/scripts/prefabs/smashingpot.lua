local assets =
{
	Asset("ANIM", "anim/pig_ruins_pot.zip"),
}

local prefabs = 
{
    "collapse_small",
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
	inst.AnimState:PlayAnimation("idle")
end

local function fn(Sim)
    local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("pig_ruins_pot.png")

    inst.entity:AddPhysics() 
    MakeObstaclePhysics(inst, .25)         

    inst.entity:AddSoundEmitter()
    inst:AddTag("structure")
    
	inst.AnimState:SetBank("pig_ruins_pot")
    inst.AnimState:SetBuild("pig_ruins_pot")    
    inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    --[[inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)]]
    
    inst:AddComponent("inspectable")

    return inst
end


return Prefab("smashingpot", fn, assets, prefabs)