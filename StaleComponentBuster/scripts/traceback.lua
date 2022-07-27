
function traceback()
    local STARTING_STACK_DEPTH = 2
    local MAX_STACK_DEPTH = 6
    local stack_depth = 0
    local str = "Tracing back stale component's origin:"
    local info = debug.getinfo(STARTING_STACK_DEPTH)
    
    while (info ~= nil and stack_depth < MAX_STACK_DEPTH) do
        str = str.."\n\t\t"..info.source
        
        if info.name then
            str = str.." in function '"..info.name.."'"
        end
        if info.currentline and info.currentline > 0 then 
            str = str.." on line "..info.currentline
        end
        
        stack_depth = stack_depth + 1
        info = debug.getinfo(STARTING_STACK_DEPTH + stack_depth)
    end
    
    return str
end

return { traceback = traceback }