local stdio = require("@lune/stdio")
local fs = require("@lune/fs")
local task = require("@lune/task")
local process = require("@lune/process")

local function generateRojoSourcemap()
	process.spawn("rojo", {
		"sourcemap",
		"--include-non-scripts",
		"-o",
		"sourcemap.json",
		"--watch"
	}, {
		stdio = "forward",
	})
end

stdio.write(`{stdio.color("green")}Rojo is running, close the terminal to stop...{stdio.color("reset")}\n`)

local r_task = task.spawn(generateRojoSourcemap)
