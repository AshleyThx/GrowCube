local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)
local phases = require(repstorage.shared.phases).phases

local components = require(repstorage.shared.components)
local log = require(repstorage.shared.log)
local net = require(script.Parent.Parent.net)

local spawnPlayer = require(script.Parent.Parent.spawners.spawnplayer)

local hasNewPlayers, getNewPlayers, _ = planck.onEvent(players, "PlayerAdded")

return {
	name = "Player Joined",
	system = function(world: jecs.World)
		for _, player in getNewPlayers() :: ()->(number, Player) do
			log.info(`Player '@{player.Name}' joined, processing`)
			local id = spawnPlayer(world, player)
			log.info(`Player '@{player.Name}' entity spawned, id: {id}`)
		end
	end,
	phase = phases.PlayerData,
	runConditions = {hasNewPlayers},
}
