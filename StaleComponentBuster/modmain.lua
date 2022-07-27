local debug = require("traceback")

local AllComponents = {}

local function whoisfn(GUID)
    if AllComponents[GUID] ~= nil then
        local prefab = AllComponents[GUID]
        if GLOBAL.Ents[GUID] ~= nil then
            print("GUID "..GUID.." belongs to an active entity of "..prefab..".")
        else
            print("GUID "..GUID.." belongs to a stale entity of "..prefab..".")
        end
    else
        print("GUID "..GUID.." does not belong to any entity.")
    end
end

AddGlobalClassPostConstruct("entityscript", "EntityScript", function(self)
    local _GetPosition = self.GetPosition
    self.GetPosition = function(self)
        if self.prefab and self:HasTag("player") and (AllComponents[self.GUID] == nil or AllComponents[self.GUID] ~= self.prefab) then
            AllComponents[self.GUID] = self.prefab
            print("GUID: "..self.GUID.." - "..self.prefab.." - "..self.name.." - "..self.userid)
        end
        if GLOBAL.Ents[self.GUID] == nil then
            -- stale component detected
            print("Stale Component Reference: GUID "..self.GUID.." ("..(self.prefab or 'nil').."), scripts/entityscript.lua:1065")
            print(debug.traceback())
        end
        return _GetPosition(self)
    end
end)

GLOBAL.WhoIs = whoisfn