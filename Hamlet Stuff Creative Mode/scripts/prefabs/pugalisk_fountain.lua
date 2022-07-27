local assets =
{
    Asset("ANIM", "anim/python_fountain.zip"),      
}

local prefabs =
{
    --"waterdrop",
    --"lifeplant",
}

local PETALSPERDAY = 5
local MAXPETALS = 5
local RESTING_TIME = 5

local function GetTime(inst, stage, data)
    if stage == 1 then
        return (TUNING.TOTAL_DAY_TIME - RESTING_TIME) / PETALSPERDAY
    end
    return RESTING_TIME
end

local function PlantFlower(inst)
	local minrad = 2
	local maxrad = 3
    
	if not inst then return end
	local pt = inst:GetPosition()
    
	local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, maxrad, {"flower"})
	if #ents >= MAXPETALS then return end
    
    local childtype
    local rand = math.random()
	if rand < 0.40 then
        childtype = "flower_rainforest"
    elseif rand < 0.80 then
        childtype = "flower_evil"
    else
        childtype = "flower_rose"
    end
    
	local angle = math.random() * 2 * PI
	local radius = math.random() * (maxrad - minrad) + minrad
	local offset, check_angle, deflected = FindWalkableOffset(pt, angle, radius, 8, true, false)
    
	if (not check_angle) then return end
	pt.x = pt.x + radius * math.cos(check_angle)
	pt.z = pt.z - radius * math.sin(check_angle)
    
	SpawnPrefab(childtype).Transform:SetPosition(pt:Get())
end

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

    inst.AnimState:SetBuild("python_fountain")    
    inst.AnimState:SetBank("fountain")
    inst.AnimState:PlayAnimation("flow_loop", true)
    
	inst:AddTag("watersource")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")
    
    MakeObstaclePhysics(inst, 2)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("pig_ruins_well.png")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	--inst:AddComponent("lootdropper")
	
	--inst:AddComponent("hauntable")
    --inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	--[[inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 
	inst.components.workable:SetWorkLeft(5)]]
    
	inst:AddComponent("growable")
	inst.components.growable.stages = {
        {
            name = "Spawning Flower",
            time = GetTime,
        },
        {
            name = "Resting",
            time = GetTime,
            fn = PlantFlower,
        },
	}
	inst.components.growable.loopstages = true
	inst.components.growable:StartGrowing()

	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aura = TUNING.SANITYAURA_SMALL * 2
	
    return inst
end

return Prefab("pugalisk_fountain", fn, assets, prefabs)


