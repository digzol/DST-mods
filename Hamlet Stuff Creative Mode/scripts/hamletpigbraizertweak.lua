local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
local Ingredient = GLOBAL.Ingredient
local resolvefilepath = GLOBAL.resolvefilepath
local RECIPETABS = GLOBAL.RECIPETABS
local resolvefilepath = GLOBAL.resolvefilepath
local SpawnPrefab = GLOBAL.SpawnPrefab
local G = GLOBAL 

-- Permanent Pig Braziers -- Thanks Adai!
local function new_DoDelta(self, amount)
    local oldsection = self:GetCurrentSection()
    local newsection = (self:GetCurrentSection() + 1) % 5

	self.currentfuel = math.max(0, math.min(self.maxfuel, self.maxfuel * (newsection-0.5)/4.0) )

    if oldsection ~= newsection then
        if self.sectionfn then
            self.sectionfn(newsection, oldsection, self.inst)
        end
        if self.currentfuel <= 0 and self.depleted then
            self.depleted(self.inst)
        end
    end

    self:StopConsuming()
    self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
end


local function AddEternalFn(inst)
	if not GLOBAL.TheWorld.ismastersim then
		return inst
	end

	inst:AddTag('eternal')
	local fueled = inst.components.fueled
	if fueled then
		fueled:StopConsuming()
		fueled.DoDelta = new_DoDelta
	end
end

AddPrefabPostInit('pig_ruins_torch', AddEternalFn)