
local assets =
{
	Asset("ANIM", "anim/rock_flipping.zip"),
	-- Asset("MINIMAP_IMAGE", "rock_flipping"),
}

local prefabs =
{
	"flint",
	"rocks",
}

local function ontransplantfn(inst)
	inst.components.pickable:MakeBarren()
end

local function makeemptyfn(inst)
end

local function makebarrenfn(inst)
end

local function wobble(inst)
	if inst.AnimState:IsCurrentAnimation("idle") then
		inst.AnimState:PlayAnimation("wobble")
		inst.AnimState:PushAnimation("idle")
	end
end

local function dowobbletest(inst)
	if math.random() < 0.5 then
		wobble(inst)
	end
end

local function onpickedfn(inst, picker)
	inst.AnimState:PlayAnimation("flip_over", false)
	local pt = Point(inst.Transform:GetWorldPosition())
	inst.components.lootdropper:DropLoot(pt)

	inst.flipped = true
end

local function makefullfn(inst)
end

local function onsave(inst, data)
	if inst.flipped then
		data.flipped = true
	end
end

local function onload(inst, data)
	-- just from world gen really
	if data and data.makebarren then
		makebarrenfn(inst)
		inst.components.pickable:MakeBarren()
	end

	if data and data.flipped then
		inst.flipped = true
		inst.AnimState:PlayAnimation("idle_flipped")
	end
end

--[[local function setloot(inst)
    local ground = GetWorld()
    local pt = Vector3(inst.Transform:GetWorldPosition())
    local tile = ground.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
    if tile == GROUND.FIELDS then
	    inst.components.lootdropper:AddRandomLoot("rocks", 20.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("flint", 20.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("cutgrass", 20.0) -- Weighted average
    elseif tile == GROUND.RAINFOREST then
	    inst.components.lootdropper:AddRandomLoot("rocks", 15.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("flint", 15.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("cutgrass", 10.0) -- Weighted average	
    elseif tile == GROUND.DEEPRAINFOREST then
	    inst.components.lootdropper:AddRandomLoot("rocks", 5.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("flint", 5.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("cutgrass", 5.0) -- Weighted average	    
	else
	    inst.components.lootdropper:AddRandomLoot("rocks", 20.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("flint", 20.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("cutgrass", 20.0) -- Weighted average
    end
end]]


local function fn(Sim)
	local inst = CreateEntity()

	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local minimap = inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	inst.entity:AddSoundEmitter()
    
    inst.OnSave = onsave
	inst.OnLoad = onload

	inst:AddTag("rock")
	inst:AddTag("flippable")
	
	MakeObstaclePhysics(inst, .1)

	inst.AnimState:SetBank("flipping_rock")
	inst.AnimState:SetBuild("rock_flipping")
	inst.AnimState:PlayAnimation("idle", true)

	inst.MiniMapEntity:SetIcon("rock_flipping.png")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("pickable")
	inst.components.pickable:SetUp(nil, nil)	
	inst.components.pickable.onpickedfn = onpickedfn
	inst.components.pickable.makeemptyfn = makeemptyfn
	inst.components.pickable.makebarrenfn = makebarrenfn
	inst.components.pickable.makefullfn = makefullfn
	inst.components.pickable.ontransplantfn = ontransplantfn
	inst.components.pickable.quickpick = true
	inst.spawnsperd = true

	--[[inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.components.workable:SetWorkLeft(3)

	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)
			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
				inst:Remove()
			end
		end)]]

	inst:AddComponent("lootdropper")
    inst.components.lootdropper.numrandomloot = 1
    inst.components.lootdropper.chancerandomloot = 1.0 -- drop some random item X% of the time
    inst.components.lootdropper.alwaysinfront = true
    --inst:DoTaskInTime(0,function() setloot(inst) end)

	inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "rock"
	inst:DoPeriodicTask(10+(math.random()*10),function() dowobbletest(inst) end)

	return inst
end

return Prefab("rock_flippable", fn, assets, prefabs)
