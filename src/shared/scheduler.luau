local repstorage = game:GetService("ReplicatedStorage")
local runservice = game:GetService("RunService")

local planck = require(repstorage.packages.planck)
local planckjabby = require(repstorage.packages.planckjabby)
local phases = require(repstorage.shared.phases)

local world = require(repstorage.shared.world)

local scheduler = planck.Scheduler.new(world)

local planckjabby_plugin = planckjabby.new()

scheduler:addPlugin(planckjabby_plugin :: any)

for event_name, pipeline in phases.pipelines :: {[string]: planck.Pipeline} do
	if event_name == "Startup" then continue end
	scheduler:insert(pipeline, runservice, event_name)
end

local scheduler_internal = scheduler :: any
scheduler_internal._defaultPhase = phases.phases.Update
scheduler_internal._defaultDependencyGraph = (phases.pipelines.Heartbeat :: any).dependencyGraph

return scheduler
