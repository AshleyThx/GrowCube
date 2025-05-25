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
	name = "Net Step",
	system = function(world: jecs.World)
		net.stepReplication()
	end,
	phase = phases.phases.ReplicationSend,
	runConditions = {},
}