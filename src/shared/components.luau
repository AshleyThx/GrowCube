local repstorage = game:GetService("ReplicatedStorage")

local jecs = require(repstorage.packages.jecs)

local world = require(repstorage.shared.world)

local components = {
	Component = jecs.Component,
	Name = jecs.Name,
	Replicate = world:component() :: jecs.Id<nil>,

	GlobalState = world:component() :: jecs.Id<{}>,

	PlayerState = world:component() :: jecs.Id<{ loaded: boolean, id: number }>,

	Model = world:component() :: jecs.Id<{ model: Model, no_cleanup: boolean? }>,
	PlantWorld = world:component() :: jecs.Id<{ pos: Vector3, growth: number }>,
	PlantType = world:component() :: jecs.Id<{ growth_factor: number, cost: number }>,
	PlantModificator = world:component() :: jecs.Id<{ growth_multiplier: number, cost_multiplier: number }>,
}

for name, component in components :: { [string]: jecs.Id } do
	world:set(component, jecs.Name, name)
end

return components
