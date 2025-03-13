-- filepath: ReplicatedStorage.RoLib_Rojo.Include.Loader.luau
--[[
    Entry Point of the RoLib Library Loading System

    This module serves as the main inclusion point for RoLib, automatically loading all packages 
    with a prioritization system based on their dependencies on other packages.  

    Packages should be placed in `ReplicatedStorage.RoLib_Rojo.Lib` for better organization 
    and automatic loading.

    Author: BlockGuard Software Foundation
    Version: 1.0.0
--]]

local RLLoader = {} -- (= RoLib Loader)



return RLLoader