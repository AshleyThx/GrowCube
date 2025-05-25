local repstorage = game:GetService("ReplicatedStorage")

local planck = require(repstorage.packages.planck)

local pipelines = {
	Startup = planck.Pipeline.Startup,
	PreRender = planck.Pipeline.new("PreRenderPipeline"),
	PreAnimation = planck.Pipeline.new("PreAnimationPipeline"),
	PreSimulation = planck.Pipeline.new("PreSimulationPipeline"),
	PostSimulation = planck.Pipeline.new("PostSimulationPipeline"),
	Heartbeat = planck.Pipeline.new("HeatbeatPipeline"),
}

local phases = {}

phases.PreStartup = planck.Phase.PreStartup
phases.Startup = planck.Phase.Startup
phases.PostStartup = planck.Phase.PostStartup

phases.PreRender = planck.Phase.new("PreRenderPhase")
pipelines.PreRender:insert(phases.PreRender)

phases.ReplicationRecieve = planck.Phase.new("ReplicationReceivePhase")
phases.PreAnimation = planck.Phase.new("PreAnimationPhase")
phases.Cleanup = planck.Phase.new("CleanupPhase")
pipelines.PreAnimation:insert(phases.ReplicationRecieve):insert(phases.PreAnimation):insert(phases.Cleanup)

phases.PreSimulation = planck.Phase.new("PreSimulationPhase")
pipelines.PreSimulation:insert(phases.PreSimulation)

phases.PostSimulation = planck.Phase.new("PostSimulationPhase")
pipelines.PostSimulation:insert(phases.PostSimulation)

phases.PlayerData = planck.Phase.new("PlayerDataPhase")
phases.PreUpdate = planck.Phase.new("PreUpdatePhase")
phases.Update = planck.Phase.new("UpdatePhase")
phases.PostUpdate = planck.Phase.new("PostUpdatePhase")
phases.ReplicationSend = planck.Phase.new("ReplicationSendPhase")
pipelines.PreAnimation
	:insert(phases.PlayerData)
	:insert(phases.PreUpdate)
	:insert(phases.Update)
	:insert(phases.PostUpdate)
	:insert(phases.ReplicationSend)

return {
	phases = phases,
	pipelines = pipelines,
}
