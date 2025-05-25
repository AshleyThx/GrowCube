local players = game:GetService("Players")
local repstorage = game:GetService("ReplicatedStorage")

local shared_constants = require(repstorage.shared.constants)

return setmetatable({
	CLIENT = players.LocalPlayer,
	CLIENT_ID = players.LocalPlayer.UserId,

	CLIENT_GUI = players.LocalPlayer:FindFirstAncestorOfClass("PlayerGui")
		or players.LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui,
}, { __index = shared_constants })
