local stdio = require("@lune/stdio")
local fs = require("@lune/fs")
local task = require("@lune/task")
local process = require("@lune/process")

if not fs.isDir("build") then
	fs.writeDir("build")
end

local function runRojoBuild()
	process.spawn("rojo", {
		"build",
		"--output",
		"build/project.rbxl"
	}, {
		stdio = "forward",
	})
end

runRojoBuild()