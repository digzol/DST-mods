local assets =
{
	Asset("ANIM", "anim/nettle.zip"),
	-- Asset("IMAGE", "images/inventoryimages/inventoryimages.tex"),
	Asset("ATLAS", "images/inventoryimages/inventoryimages2.xml"),
}

local prefabs =
{
	"dug_berrybush",
}

local function onpickedfn(inst)
	inst:Remove()
end


local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    inst.AnimState:SetBank("nettle")
    inst.AnimState:SetBuild("nettle")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddComponent("inspectable")

    --[[inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("cutlichen", 10)
	inst.components.pickable.onpickedfn = onpickedfn

    inst.components.pickable.quickpick = false]]

	--MakeSmallBurnable(inst)
    --MakeSmallPropagator(inst)

    return inst
end

return Prefab("nettle", fn, assets)