local repstorage = game:GetService("ReplicatedStorage")

local jecs = require(repstorage.packages.jecs)

local world = require(repstorage.shared.world)

local data = require(repstorage.shared.data)

local components = {
	--- builtin component component
	Component = jecs.Component,

	--- builtin name component
	Name = jecs.Name,

	--- builtin name component
	Replicate = world:component() :: jecs.Id<unknown>,

	--- component describing global data of this world
	GlobalState = world:component() :: jecs.Id<{}>,

	--- component describing player data
	PlayerState = world:component() :: jecs.Id<{ loaded: boolean, id: number }>,

	--- component describing a model of an entity in roblox workspace
	Model = world:component() :: jecs.Id<{ model: Model, no_cleanup: boolean? }>,

	--- component describing a existing planted plant in this world
	PlantWorld = world:component() :: jecs.Id<{ pos: Vector3, growth: number }>,

	--- component describing an abstract plant in this world
	--- exists for plants in any form, planted or not
	-- type_id (or simply plant name) is stored here only for data saving and other scenarios where just plant properties are not enough
	PlantType = world:component() :: jecs.Id<{
		type_id: keyof<typeof(data.plant_types)>,
		growth_factor: number,
		cost: number,
	}>,

	--- component describing an modificators of an abstract plant in this world
	PlantModificators = world:component() :: jecs.Id<{
		mod_id: keyof<typeof(data.plant_modificators)>,
		growth_multiplier: number,
		cost_multiplier: number,
	}>,
}

--
for name, component in components :: { [string]: jecs.Id } do
	world:set(component, jecs.Name, name)
end

return components
