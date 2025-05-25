local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)
local phases = require(repstorage.shared.phases)

local components = require(repstorage.shared.components)
local log = require(repstorage.shared.log)
local net = require(script.Parent.Parent.net)

local replication = require(repstorage.shared.replication)

return {
	name = "Client Replication Recieve",
	system = function(world: jecs.World)
		for _, component, entities in net.replication.component.iter() do
			replication:apply({ [component] = entities } :: any)
		end
	
		for name, id in components :: {[string]: jecs.Id} do
			local remote = (net :: any)[`component_{world:get(id, jecs.Name)}`]
			if not remote then
				continue
			end
			
			for _, entities in remote.iter() do
				replication:apply({ [id] = entities } :: any)
			end
		end
	
		for _, entities in net.replication.entityDeleted.iter() do
			replication:apply({ __d = entities } :: any)
		end
	end,
	phase = phases.phases.ReplicationRecieve,
	runConditions = {},
}