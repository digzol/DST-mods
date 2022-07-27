local grassassets=
{
	Asset("ANIM", "anim/grass_tall.zip"),
	Asset("SOUND", "sound/common.fsb"),
	Asset("MINIMAP_IMAGE", "grass"),
}

local grassprefabs =
{
	--"weevole",
    "cutgrass",
    "dug_grass",
   	--"hacking_tall_grass_fx",
}

local waterprefabs =
{
    "cutgrass"
}

local function ontransplantfn(inst)
	if inst.components.pickable then
		inst.components.pickable:MakeBarren()
	end
end

local function onregenfn(inst)
	inst.AnimState:PlayAnimation("grow") 
	inst.AnimState:PushAnimation("idle", true)
end

local function makeemptyfn(inst)
	if inst.components.pickable and inst.components.pickable.withered then
	inst.AnimState:PlayAnimation("dead_to_empty")
	inst.AnimState:PushAnimation("picked",false)	
	else
	inst.AnimState:PlayAnimation("picked")	
	end
end

local function makebarrenfn(inst)
	if inst.components.pickable and inst.components.pickable.withered then
		if not inst.components.pickable.hasbeenpicked then
			inst.AnimState:PlayAnimation("full_to_dead" or "empty_to_dead")
			inst.AnimState:PushAnimation("idle_dead", false)
	else
		inst.AnimState:PlayAnimation("idle_dead")
	end
	end 
end

local function onpickedfn(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds") 
	inst.AnimState:PlayAnimation("picking") 
	
	if inst.components.pickable and inst.components.pickable:IsBarren() then
		inst.AnimState:PushAnimation("empty_to_dead")
        inst.AnimState:PushAnimation("idle_dead", false)
    else
        inst.AnimState:PushAnimation("picked", false)
	end
end

local function makegrass(inst)
	inst.MiniMapEntity:SetIcon("grass.png")
	inst.AnimState:SetBank("grass_tall")	
	inst.AnimState:SetBuild("grass_tall")
end

local function makefn(stage, artfn, product, dig_product, burnable, pick_sound, patch)

	local function dig_up(inst, chopper)
		if inst.components.pickable and inst.components.pickable:CanBePicked() then
			inst.components.lootdropper:SpawnLootPrefab(product)
		end
		if inst.components.pickable and not inst.components.pickable.withered then
			local bush = inst.components.lootdropper:SpawnLootPrefab(dig_product)
		else
			inst.components.lootdropper:SpawnLootPrefab(product)
		end
		inst:Remove()
	end

	local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
	    local sound = inst.entity:AddSoundEmitter()
		local minimap = inst.entity:AddMiniMapEntity()
		inst.entity:AddNetwork()

		artfn(inst)

	    anim:PlayAnimation("idle",true)
	    
		--anim:SetTime(math.random()*2)
	    --local color = 0.75 + math.random() * 0.25
	    --anim:SetMultColour(color, color, color, 1)

	    inst:AddTag("gustable")
	    inst:AddTag("grass_tall")

		
		inst:AddComponent("pickable")
		inst.components.pickable.picksound = pick_sound
		
		inst.components.pickable:SetUp(product, TUNING.GRASS_REGROW_TIME)
		inst.components.pickable.onregenfn = onregenfn
		inst.components.pickable.onpickedfn = onpickedfn
		inst.components.pickable.makeemptyfn = makeemptyfn
		inst.components.pickable.makebarrenfn = makebarrenfn
		inst.components.pickable.max_cycles = 20
		inst.components.pickable.cycles_left = 20
		inst.components.pickable.ontransplantfn = ontransplantfn

	    -- inst:AddComponent("creatureprox")
	    -- inst.components.creatureprox:SetOnPlayerNear(onnear)
	    -- inst.components.creatureprox:SetOnPlayerFar(onfar)
	    -- inst.components.creatureprox:SetDist(0.75,1)
		
		
	    inst:AddComponent("inspectable")    
	
		--[[if dig_product ~= nil then
            inst:AddComponent("lootdropper")
			inst:AddComponent("workable")
		    inst.components.workable:SetWorkAction(ACTIONS.DIG)
		    inst.components.workable:SetOnFinishCallback(dig_up)
		    inst.components.workable:SetWorkLeft(1)
		end]]

	    -- MakeHackableBlowInWindGust(inst, TUNING.GRASS_WINDBLOWN_SPEED, 0)
	    
	    ---------------------

	    --[[if burnable then
		    MakeMediumBurnable(inst)
		    MakeSmallPropagator(inst)
		    -- inst.components.burnable:MakeDragonflyBait(1)
		end]]

		MakeNoGrowInWinter(inst)		

	    return inst
	end

    return fn
end

return Prefab("grass_tall", makefn(0, makegrass, "cutgrass", "dug_grass", true, "dontstarve/wilson/pickup_reeds"), grassassets, grassprefabs)