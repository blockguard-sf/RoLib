--filepath: ReplicatedStorage.RoLib_Rojo.API
--[[
    RoLib Library API Entry Point

    This module serves as the main inclusion point for the RoLib API, allowing access to packages 
    loaded by the RoLib loading system.  

    To use this API, scripts simply need to:  
        local RoLibAPI = require(game:GetService("ReplicatedStorage"):WaitForChild("RoLib_Rojo").API)

    and then access packages like:  
        local logging = API.logging  
        logging:SetLog("Hello from RoLib!", "INFO")

    Author: BlockGuard Software Foundation  
    Version: 1.0.0  
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoLib = ReplicatedStorage:WaitForChild("RoLib_Rojo")

local Loader = require(RoLib:WaitForChild("Include"):WaitForChild("Loader"))

local API = {} :: {}
setmetatable(API, {
    __index = function(_, key: string)
        if Loader.__packages[key] == nil then
            warn("RoLib: Package '" .. key .. "' does not exist in the RoLib API.")
        end
        return Loader.__packages[key]
    end
})

return API