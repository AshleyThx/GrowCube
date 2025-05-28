local repstorage = game:GetService("ReplicatedStorage")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)

local components = require(repstorage.shared.components)
local log = require(repstorage.shared.utils.log)
local net = require(script.Parent.Parent.net)

return function(world: jecs.World, player: Player)
	local entity = world:entity()
	world:set(entity, jecs.Name, player.Name)

	world:set(entity, components.PlayerState, {
		loaded = true,
		id = player.UserId,
		coins = 0,
	})
	world:add(entity, components.Replicate)

	return entity
end
