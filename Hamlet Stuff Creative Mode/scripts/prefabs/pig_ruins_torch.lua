require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/ruins_torch.zip"),
    Asset("MINIMAP_IMAGE", "ruins_torch"), 
}

local prefabs =
{
    "campfirefire"
}    

local function onignite(inst)
	if inst.components.fueled then
		inst.components.fueled:InitializeFuelLevel(2)
	end
	local pt = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 50,{"pig_ruins_torch"})
    for i, ent in ipairs(ents) do      
        ent:PushEvent("fire_lit")        
    end
end

local function onextinguish(inst)
    if inst.components.fueled ~= nil then
        inst.components.fueled:InitializeFuelLevel(0)
    end
end

local function ontakefuel(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
end

local function onhammered(inst, worker)
    local x, y, z = inst.Transform:GetWorldPosition()
    SpawnPrefab("ash").Transform:SetPosition(x, y, z)
	SpawnPrefab("cutstone").Transform:SetPosition(x, y, z)
    SpawnPrefab("collapse_small").Transform:SetPosition(x, y, z)
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:PushAnimation("idle", true)
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:PushAnimation("idle", true)
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:PushAnimation("idle", false)
end

local function updatefuelrate(inst)
    inst.components.fueled.rate = TheWorld.state.israining and 1 + TUNING.FIREPIT_RAIN_RATE * TheWorld.state.precipitationrate or 1
end

local function onupdatefueled(inst)
    if inst.components.burnable ~= nil and inst.components.fueled ~= nil then
        updatefuelrate(inst)
        inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
    end
end

local function onfuelchange(newsection, oldsection, inst)
    if newsection <= 0 then
        inst.components.burnable:Extinguish()
    else
        if not inst.components.burnable:IsBurning() then
            updatefuelrate(inst)
            inst.components.burnable:Ignite()
        end
        inst.components.burnable:SetFXLevel(newsection, inst.components.fueled:GetSectionPercent())
    end
end

local SECTION_STATUS =
{
    [0] = "OUT",
    [1] = "EMBERS",
    [2] = "LOW",
    [3] = "NORMAL",
    [4] = "HIGH",
}
local function getstatus(inst)
    return SECTION_STATUS[inst.components.fueled:GetCurrentSection()]
end

local function OnInit(inst)
    if inst.components.burnable ~= nil then
        inst.components.burnable:FixFX()
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    anim:SetBank("pigtorch")
    anim:SetBuild("ruins_torch")
    anim:PlayAnimation("idle")
    
    ---inst.AnimState:SetRayTestOnBB(true);
    --inst:AddTag("campfire")
    --inst:AddTag("structure")
	--inst:AddTag("wildfireprotected")    
	
    MakeObstaclePhysics(inst, .2)    
    
	if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddTag("cooker")
    inst:AddComponent("cooker")

    inst:AddComponent("burnable")
    inst.components.burnable:AddBurnFX("campfirefire", Vector3(-70,5,0), "fire_marker" )
    inst.components.burnable:SetFXLevel(4, 1)
    inst.components.burnable:Ignite()
    --inst:ListenForEvent("onextinguish", onextinguish)
    --inst:ListenForEvent("onignite", onignite)

    -------------------------
    --[[inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.CAMPFIRE_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(4)
    inst.components.fueled:InitializeFuelLevel(0)
	-- inst.components.fueled:StopConsuming()
	
	inst.components.fueled:SetSections(4)
    inst.components.fueled.bonusmult = TUNING.FIREPIT_BONUS_MULT
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:SetUpdateFn(onupdatefueled)
    inst.components.fueled:SetSectionCallback(onfuelchange)
    inst.components.fueled:InitializeFuelLevel(TUNING.FIREPIT_FUEL_START)]]
    -----------------------------
	--[[inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)]]
    
    inst:AddComponent("inspectable")
    --------------------

    --inst.OnSave = onsave 
    --inst.OnLoad = onload 
	inst:DoTaskInTime(0, OnInit)
           
    return inst
end

local function pillarfn(Sim)
    local inst = fn(Sim)
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("ruins_torch.png")
    return inst
end

return Prefab("pig_ruins_torch", pillarfn, assets, prefabs)