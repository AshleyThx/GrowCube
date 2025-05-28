local repstorage = game:GetService("ReplicatedStorage")

local sift = require(repstorage.packages.sift)

local data = {}

-- PLANT TYPES
local plant_types = require(script.raw.planttypes)
export type PlantType = typeof(plant_types.UNIQUE)
plant_types = plant_types :: { [keyof<typeof(plant_types)>]: PlantType }
data.plant_types = plant_types

-- PLANT MODIFICATORS
local plant_modificators = require(script.raw.plantmodificators)
export type PlantModificator = typeof(plant_modificators.UNIQUE)
plant_modificators = plant_modificators :: { [keyof<typeof(plant_modificators)>]: PlantModificator }
data.plant_modificators = plant_modificators

-- patches every data entry in every category using the template (UNIQUE) from the same category
for category_name, category in data :: any do -- new type solver gets quirky sometimes
	local template = category.UNIQUE
	for name, entry in category do
		if typeof(entry) ~= "table" then continue end
		entry = sift.Dictionary.filter(entry :: any, function(key, val)
			return typeof(key) == "string" and typeof(category.UNIQUE[key]) == typeof(val)
		end)
		entry = sift.Dictionary.join(entry, plant_types.UNIQUE)
		category[name] = table.freeze(entry :: {})
	end
end

return table.freeze(data)
