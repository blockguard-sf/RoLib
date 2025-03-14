--!nocheck
--filepath: ReplicatedStorage.RoLib_Rojo.Include.RoLib.Priorities
--[[
    Prioritization System for RoLib Package Loading

    This module serves as a prioritization system for RoLib package loading. 
    It is used to determine the order in which packages are loaded based on their dependencies.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoLib = ReplicatedStorage:WaitForChild("RoLib_Rojo")

local Library = RoLib:WaitForChild("Lib")

local Priorities = {}
Priorities.__index = Priorities

function Priorities.new(name, dependencies: table): table
    local self = setmetatable({}, Priorities)
    self.Dependencies = #dependencies + 1
    
    if #dependencies > 0 then
        local dependencyCount = dependencies
        for index, dependency in ipairs(dependencies) do
            for _, package in pairs(Library:GetChildren()) do
                if package.Name == dependency then
                    table.remove(dependencyCount, index)
                    continue
                end
            end
        end

        if #dependencyCount ~= 0 then
            warn("RoLib: Missing dependencies for the '" .. name .. "' package: " .. table.concat(dependencyCount, ", "))
            return false
        end
    end
    return self
end

return Priorities