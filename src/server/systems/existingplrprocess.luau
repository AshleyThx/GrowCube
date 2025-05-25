local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)
local phases = require(repstorage.shared.phases).phases

local components = require(repstorage.shared.components)
local log = require(repstorage.shared.log)
local net = require(script.Parent.Parent.net)

local spawnPlayer = require(script.Parent.Parent.spawners.spawnplayer)

return {
	name = "Process Existing Players",
	system = function(world: jecs.World)
		log.info("Processing already existing players")
		for id, player in players:GetPlayers() do
			log.info(`Player '@{player.Name}' found, spawning entity`)
			spawnPlayer(world, player)
			log.info(`Player '@{player.Name}' entity spawned, id: {id}`)
		end
	end,
	phase = phases.Startup,
	runConditions = {},
}