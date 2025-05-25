local repstorage = game:GetService("ReplicatedStorage")

export type World = typeof(require(repstorage.shared.world))
export type SystemFn = (world: World) -> ()

return true
