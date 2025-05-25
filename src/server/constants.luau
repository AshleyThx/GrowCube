local players = game:GetService("Players")
local runservice = game:GetService("RunService")
local repstorage = game:GetService("ReplicatedStorage")

local shared_constants = require(repstorage.shared.constants)

return setmetatable({
	
}, {__index = shared_constants})