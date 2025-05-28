local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)
local phases = require(repstorage.shared.phases).phases

local components = require(repstorage.shared.components)
local log = require(repstorage.shared.utils.log)
local net = require(script.Parent.Parent.net)

local replication = require(repstorage.shared.replication)

local function fire(player: Player, component: jecs.Id, entities: any, world: jecs.World)
	local remote = (net :: any)[`component_{world:get(component, jecs.Name)}`]
	if remote == nil then
		net.replication.component.fire(player, component :: any, entities)
		return
	end

	remote.fire(player, entities)
end

return {
	name = "Server Replication",
	system = function(world: jecs.World)
		local full_packet = nil
		for _, reciever in net.replication.requestFullPacket.iter() do
			full_packet = full_packet or replication:full()
			for component, data in full_packet do
				fire(reciever, component, data, world)
			end
		end
		
		local changes, deleted = replication:delta()
		for component, recievers in changes do
			for player, entities in recievers do
				fire(player, component, entities, world)
			end
		end
		for player, entities: { number } in deleted :: {[Player]: {number}} do
			net.replication.entityDeleted.fire(player, entities)
		end

		net.stepReplication()
	end,
	phase = phases.ReplicationSend,
	runConditions = {},
}