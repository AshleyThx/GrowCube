--!nonstrict

local repstorage = game:GetService("ReplicatedStorage")

local react = require(repstorage.packages.react)
local reactroblox = require(repstorage.packages.reactroblox)
local constants = require(repstorage.clientcore.constants)

local e = react.createElement

local function createApp()
	local root = reactroblox.createRoot(Instance.new("Folder"))
	local app = require(script.Parent.app)
	root:render(reactroblox.createPortal(e(react.StrictMode, {}, {app = e(app)}), constants.CLIENT_GUI))
end

return {
	createApp = createApp
}