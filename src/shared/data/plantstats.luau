local repstorage = game:GetService("ReplicatedStorage")

local sift = require(repstorage.packages.sift)

export type PlantData = {
	name: string,
	cost: number,
	growth_factor: number,
}
local template: PlantData = {
	name = "BLANK",
	cost = 0,
	growth_factor = 1,
}

local stats: { [string]: PlantData } = {
	carrot = {
		name = "Carrot",
		cost = 0,
		growth_factor = 1 / 10,
	},
}

for name, p_data in stats do
	p_data = sift.Dictionary.filter(
		p_data :: any,
		(
				function(key, val)
					return typeof(key) == "string" and typeof((template :: any)[key]) == typeof(val)
				end
			) :: any
	)
	p_data = sift.Dictionary.join(p_data, template) :: any
	stats[name] = table.freeze(p_data :: {}) :: PlantData
end

return table.freeze(stats)
