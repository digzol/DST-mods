local assets = {
    Asset("ANIM", "anim/turf_1.zip")
}

local prefabs = {
    "gridplacer"
}

local function make_turf(data)
    local function ondeploy(inst, pt, deployer)
        if deployer ~= nil and deployer.SoundEmitter ~= nil then
            deployer.SoundEmitter:PlaySound("dontstarve/wilson/dig")
        end

        local map = TheWorld.Map
        local original_tile_type = map:GetTileAtPoint(pt:Get())
        local x, y = map:GetTileCoordsAtPoint(pt:Get())
        if x ~= nil and y ~= nil then
            map:SetTile(x, y, data.tile)
            map:RebuildLayer(original_tile_type, x, y)
            map:RebuildLayer(data.tile, x, y)
        end

        local minimap = TheWorld.minimap.MiniMap
        minimap:RebuildLayer(original_tile_type, x, y)
        minimap:RebuildLayer(data.tile, x, y)

        inst.components.stackable:Get():Remove()
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("turf")
        inst.AnimState:SetBuild("turf_1")
        inst.AnimState:PlayAnimation(data.anim)

        inst:AddTag("groundtile")
        inst:AddTag("molebait")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "images/inventoryimages/inventoryimages2.xml"

        inst:AddComponent("bait")

        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = TUNING.MED_FUEL
        MakeMediumBurnable(inst, TUNING.MED_BURNTIME)
        MakeSmallPropagator(inst)
        MakeHauntableLaunchAndIgnite(inst)

        inst:AddComponent("deployable")
        inst.components.deployable:SetDeployMode(DEPLOYMODE.TURF)
        inst.components.deployable.ondeploy = ondeploy
        inst.components.deployable:SetUseGridPlacer(true)

        ---------------------
        return inst
    end

    return Prefab("turf_" .. data.name, fn, assets, prefabs)
end

local turfs = {
    {name = "pigruins", anim = "pig_ruins", tile = GROUND.PIGRUINS}, -- 1
    {name = "rainforest", anim = "rainforest", tile = GROUND.RAINFOREST}, -- 2
    {name = "deeprainforest", anim = "deepjungle", tile = GROUND.DEEPRAINFOREST}, -- 3
    {name = "checkeredlawn", anim = "checkeredlawn", tile = GROUND.CHECKEREDLAWN}, -- 4
    {name = "gasjungle", anim = "gasjungle", tile = GROUND.GASJUNGLE}, -- 5
    {name = "moss", anim = "mossy_blossom", tile = GROUND.SUBURB}, -- 6
    {name = "fields", anim = "farmland", tile = GROUND.FIELDS}, -- 7
    {name = "foundation", anim = "fanstone", tile = GROUND.FOUNDATION}, -- 8
    {name = "cobbleroad", anim = "cobbleroad", tile = GROUND.COBBLEROAD}, -- 9
	{name = "antfloor", anim = "antcave", tile = GROUND.ANTFLOOR}, -- 10
	{name = "batfloor", anim = "batcave", tile = GROUND.BATFLOOR}, -- 11
	{name = "battlegrounds", anim = "battlegrounds", tile = GROUND.BATTLEGROUNDS}, -- 12
	{name = "bog", anim = "bog", tile = GROUND.BOG}, -- 13
	{name = "plains", anim = "plains", tile = GROUND.PLAINS}, -- 14
	{name = "beardrug", anim = "beard_hair", tile = GROUND.BEARDRUG},	 -- 15
}

local hturfs = {}
for _, v in ipairs(turfs) do
    table.insert(hturfs, make_turf(v))
end
return unpack(hturfs)