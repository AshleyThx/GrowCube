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

local useDeltaTime = require(repstorage.shared.utils.usedeltatime)()

return {
	name = "Plant World Growth",
	system = function(world: types.World)
		local dt = useDeltaTime()
		for id, p_type, p_world, p_mod in world:query(components.PlantType, components.PlantWorld, components.PlantModificator):iter() do
			local growth: number = p_world.growth or 0
			if growth >= 1 then continue end

			local growth_delta: number = dt * p_type.growth_factor * p_mod.growth_multiplier
			world:set(id, components.PlantWorld, sift.Dictionary.join(p_world, {growth = math.clamp(growth + growth_delta, 0, 1)}))
		end
	end,
	phase = phases.Update,
	runConditions = {planck.timePassed(1/5)}, -- limiting time to avoid performance drops due to large amounts of plants
}
