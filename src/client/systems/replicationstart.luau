local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)
local phases = require(repstorage.shared.phases)

local components = require(repstorage.shared.components)
local log = require(repstorage.shared.log)
local net = require(script.Parent.Parent.net)

return {
	name = "Client Replication Startup",
	system = function(world: jecs.World)
		net.replication.requestFullPacket.fire()
		log.info("Requested full packet from the server")
	end,
	phase = phases.phases.Startup,
	runConditions = {},
}