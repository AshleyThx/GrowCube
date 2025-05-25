local repstorage = game:GetService("ReplicatedStorage")

local jecs = require(repstorage.packages.jecs)
local jecsobservers = require(repstorage.shared.plugins.observers)

local world = jecsobservers(jecs.World.new())

return world
