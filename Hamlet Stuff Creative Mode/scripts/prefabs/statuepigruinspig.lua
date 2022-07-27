local assets =
{
    Asset("ANIM", "anim/statue_pig_ruins_pig.zip"),      
}

local function OnWork(inst, worker, workleft)
    if workleft <= 0 then
        local pos = inst:GetPosition()
        SpawnPrefab("rock_break_fx").Transform:SetPosition(pos:Get())
        inst.components.lootdropper:DropLoot(pos)
        inst:Remove()
    elseif workleft < TUNING.MARBLEPILLAR_MINE / 3 then
        inst.AnimState:PlayAnimation("low")
        inst.AnimState:PushAnimation("low")
    elseif workleft < TUNING.MARBLEPILLAR_MINE * 2 / 3 then
        inst.AnimState:PlayAnimation("med")
        inst.AnimState:PushAnimation("med")
    else
        inst.AnimState:PlayAnimation("full")
        inst.AnimState:PushAnimation("full")
    end
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

    inst.AnimState:SetBuild("statue_pig_ruins_pig")    
    inst.AnimState:SetBank("statue_pig_ruins_pig")
    inst.AnimState:PlayAnimation("full")
    
    MakeObstaclePhysics(inst, 1)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("statue_pig_ruins_ant.pig")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	
	--[[inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.MARBLEPILLAR_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork)]]
	
    return inst
end

return Prefab("pigstatue_pig", fn, assets, prefabs)


