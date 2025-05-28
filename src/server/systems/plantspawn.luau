local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)
local sift = require(repstorage.packages.sift)

local phases = require(repstorage.shared.phases).phases
local components = require(repstorage.shared.components)
local log = require(repstorage.shared.utils.log)
local types = require(repstorage.shared.types)
local net = require(script.Parent.Parent.net)

return {
	name = "Plant Spawn",
	system = function(world: types.World)
		for _, player, plant_name in net.plantInWorld.iter() do
			local test = world:entity()
			world:set(test, components.PlantType, {
				cost = 5,
				growth_factor = 1 / 20,
			})
			world:set(test, components.PlantWorld, {
				growth = 0,
				pos = Vector3.zero,
			})
			world:set(test, components.PlantModificators, {
				growth_multiplier = 1,
				cost_multiplier = 1,
			})
			world:set(test, components.Name, "Carrot Plant")
			log.debug(`spawned '{plant_name}' for player '@{player}' entity id: {test}`)
		end
	end,
	phase = phases.PreUpdate,
	runConditions = {},
}
