local repstorage = game:GetService("ReplicatedStorage")

local world = require(repstorage.shared.world)
local components = require(repstorage.shared.components)
local replication = require(repstorage.include.replication)

return replication.new(world, components.Replicate)