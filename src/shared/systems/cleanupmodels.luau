local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)
local phases = require(repstorage.shared.phases).phases

local components = require(repstorage.shared.components)
local log = require(repstorage.shared.log)
local net = require(script.Parent.Parent.net)

return {
	name = "Model Component Cleanup",
	system = function(world: jecs.World)
		for id, model in world:query(components.Model) do
			local model_obj = model.model
			if typeof(model_obj) ~= "Instance" then model_obj = nil end
			if (not model_obj or model_obj.Parent == nil) and not model.no_cleanup then
				if model_obj then model_obj:Destroy() end
				world:remove(id, components.Model)
			end
		end
	end,
	phase = phases.Cleanup,
	runConditions = {},
}
