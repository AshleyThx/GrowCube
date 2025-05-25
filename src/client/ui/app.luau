--!nonstrict

local repstorage = game:GetService("ReplicatedStorage")

local react = require(repstorage.packages.react)

local net = require(repstorage.clientcore.net)

local e = react.createElement

local function App(props: {}): react.ReactNode?
	return e("ScreenGui", {
		ResetOnSpawn = false,
		IgnoreGuiInset = false,
	}, {
		SpawnPlant = e("TextButton", {
			Size = UDim2.fromOffset(200, 100),
			Position = UDim2.fromOffset(100, 100),
			Text = "Spawn a plant ig",
			[react.Event.Activated] = function()
				net.plantInWorld.fire("Carrot")
			end,
		}),
	})
end

return App
