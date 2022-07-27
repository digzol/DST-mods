local assets =
{
	Asset("ANIM", "anim/fountain_pillar.zip"),
	
    Asset("MINIMAP_IMAGE", "pig_ruins_pillar"),        
}

local prefabs =
{
   
}

local back = -1
local front = 0
local left = 1.5
local right = -1.5

local function onsave(inst, data)    
    local references = {}
    data.rotation = inst.Transform:GetRotation()
    
    return references
end

local function onload(inst, data)
    if data.rotation then
        inst.Transform:SetRotation(data.rotation)
    end
    if inst.components.workable and inst.components.workable.workleft < 1 then
        inst.AnimState:PushAnimation("pillar_collapsed",true)
    end
end

local function loadpostpass(inst,ents, data)

end

local function onremove(inst)

end

local function finished(inst, worker)
	local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

SetSharedLootTable( 'pugalisk_pillar',
{
    {'rocks',  1.00},
    {'rocks',  1.00},
    {'rocks',  1.00},
    {'rocks',  0.25},
    {'rocks',  0.25},
    {'thulecite',  0.05},
})


local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()

    MakeObstaclePhysics(inst, 0.5)
    inst.Transform:SetEightFaced()

    anim:SetBuild("fountain_pillar")
    anim:SetBank("fountain_pillar")
    anim:PlayAnimation("pillar",true)
	--anim:SetOrientation( ANIM_ORIENTATION.OnGround )
	--anim:SetLayer( LAYER_BACKGROUND )
	--anim:SetSortOrder( 3 )

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("pig_ruins_pillar")

 --   inst.OnSave = onsave 
 --   inst.OnLoad = onload
 --   inst.LoadPostPass = loadpostpass

    inst:AddComponent("inspectable")

    inst.entity:AddSoundEmitter()

    --[[inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnWorkCallback(
        function(inst, worker, workleft)

        end)             
    inst.components.workable:SetOnFinishCallback(
        function(inst,worker)

            anim:PlayAnimation("pillar_collapse")
            anim:PushAnimation("pillar_collapsed")
            local pt = Point(inst.Transform:GetWorldPosition())
            inst.components.lootdropper:DropLoot(pt)
			inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
			inst.components.workable:SetWorkLeft(2)
            inst.components.workable:SetOnWorkCallback(
				function(inst, worker, workleft)
				
				end)
			inst.components.workable:SetOnFinishCallback(
				function(inst,worker)
					inst.components.lootdropper:DropLoot(pt)
					local fx = SpawnPrefab("collapse_small")
					fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
					fx:SetMaterial("stone")
					inst:Remove()
				end)
        end)
    inst:AddComponent("lootdropper") 
    inst.components.lootdropper:SetChanceLootTable('pugalisk_pillar')]]

    inst:DoTaskInTime(0,function() 

            local pt = Point(inst.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 20,{"pugalisk_fountain"})

            if ents[1] then
                local pt2 = Point(ents[1].Transform:GetWorldPosition())
                local angle = inst:GetAngleToPoint(pt2) 
                inst.Transform:SetRotation(angle)
            end
        end)
    return inst
end


return Prefab("pugalisk_ruins_pillar", fn, assets, prefabs)