--!nocheck
--filepath: ReplicatedStorage.RoLib_Rojo.Include.Loader
--[[
    Entry Point of the RoLib Library Loading System

    This module serves as the main inclusion point for RoLib, automatically loading all packages 
    with a prioritization system based on their dependencies on other packages.  

    Packages should be placed in `ReplicatedStorage.RoLib_Rojo.Lib` for better organization 
    and automatic loading.

    Author: BlockGuard Software Foundation
    Version: 1.0.0
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoLib = ReplicatedStorage:WaitForChild("RoLib_Rojo")

local Library = RoLib:WaitForChild("Lib")
local Include = RoLib:WaitForChild("Include"):WaitForChild("RoLib")

local ResolvePath = require(Include:WaitForChild("ResolvePath"))
local Priorities = require(Include:WaitForChild("Priorities"))

local RLLoader = {} :: {} -- (= RoLib Loader)
RLLoader.__packages = {} :: { string: ModuleScript }
setmetatable(RLLoader, {
    __index = function(_, key): concat<string, concat<a, string>>
        return "The key '" .. key .. "' does not exist in this module."
    end
})

-- Load all packages in the correct order
local Packages = {}
local function loadPackages(): ()
    for i = 1, #Packages do
        for name, package in pairs(Packages[i]) do
            RLLoader.__packages[name] = require(package) :: {}
        end
    end
end

-- Load all packages in the library
for _, package in ipairs(Library:GetChildren()) do
    if not package:IsA("Folder") or package.Name == "site-packages" then
        continue
    end

    package.Name = string.lower(package.Name)
    local metadata: ModuleScript? = package:FindFirstChild("Metadata")
    if not metadata:IsA("ModuleScript") then
        continue
    end

    metadata = require(metadata)
    local indexPath: Instance? = ResolvePath(metadata.Name, metadata.Main)
    if not indexPath then
        warn("RoLib: Package '" .. metadata.Name .. "' could not be loaded.")
        continue
    end

    local priority = Priorities.new(metadata.Name, metadata.Dependencies)
    if priority == false then continue end
    if Packages[priority.Dependencies] == nil then
        Packages[priority.Dependencies] = {}
    end

    Packages[priority.Dependencies][metadata.Name] = indexPath
end

loadPackages()
return RLLoader
