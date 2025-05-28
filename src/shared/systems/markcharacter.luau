local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)

local phases = require(repstorage.shared.phases).phases
local components = require(repstorage.shared.components)
local log = require(repstorage.shared.utils.log)
local net = require(script.Parent.Parent.net)
local types = require(repstorage.shared.types)

return {
	name = "Player Character Model Add",
	system = function(world: types.World)
		for id, player in world:query(components.PlayerState):without(components.Model):iter() do
			local player_obj = players:GetPlayerByUserId(player.id or 0)
			if not player_obj then continue end

			local character_obj = player_obj.Character 
			if not character_obj then continue end

			world:set(id, components.Model, {model = character_obj})
		end
	end,
	phase = phases.Update,
	runConditions = {},
}
