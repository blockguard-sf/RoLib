--!nocheck
--filepath: ReplicatedStorage.RoLib_Rojo.Include.RoLib.ResolvePath
--[[
    Resolves a path to a specific object in the RoLib Library.

    This function is used to resolve a path to a specific object in the RoLib Library. 
    It is used to simplify the process of including objects from the library.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoLib = ReplicatedStorage:WaitForChild("RoLib_Rojo")

local Library = RoLib:WaitForChild("Lib")

local ResolvePath = function(name: string, path: string)
    local package: Folder? = Library:FindFirstChild(name)
    if not package then
        warn("RoLib: Package '" .. name .. "' not found in Library.")
        return nil
    end
    
    path = path:gsub("%.luau$", ""):gsub("/", "."):gsub("\\", ".")
    local pathParts = {}
    for part in path:gmatch("([^.]+)") do
        table.insert(pathParts, part)
    end
    
    local currentObject = package
    for _, part in ipairs(pathParts) do
        currentObject = currentObject:FindFirstChild(part)
        if not currentObject then
            warn("RoLib: Part '" .. part .. "' not found in the current object")
            return nil
        end
    end

    return currentObject
end

return ResolvePath