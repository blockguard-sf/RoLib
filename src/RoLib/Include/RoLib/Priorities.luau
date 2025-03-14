--filepath: ReplicatedStorage.RoLib_Rojo.Include.RoLib.Priorities.luau
--[[
    Prioritization System for RoLib Package Loading

    This module serves as a prioritization system for RoLib package loading. 
    It is used to determine the order in which packages are loaded based on their dependencies.
--]]

local Priorities = {}
Priorities.__index = Priorities

function Priorities.new(dependencies: table): table
    local self = setmetatable({}, Priorities)
    self.Dependencies = #dependencies + 1
    return self
end

return Priorities