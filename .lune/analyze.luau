local fs = require("@lune/fs")
local process = require("@lune/process")
local net = require("@lune/net")

if not fs.isDir("build") then
	fs.writeDir("build")
end

if not fs.isDir("build/temp") then
	fs.writeDir("build/temp")
end

local def_file = net.request({
	url = "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/master/scripts/globalTypes.d.luau",
	method = "GET",
})
assert(def_file.ok, "failed to download definition files")
fs.writeFile("build/temp/globalTypes.d.luau", def_file.body)

process.spawn("rojo", {
	"sourcemap", "--include-non-scripts", "-o", "sourcemap.json",
}, {
	cwd = process.cwd,
	env = process.env,
	stdio = "forward",
})
assert(fs.isFile("sourcemap.json"), "failed to generate a sourcemap file")

process.spawn("luaulsp", {
	"analyze",
	"--settings",
	".vscode/settings.json",
	"--base-luaurc",
	"./.luaurc",
	"--sourcemap",
	"sourcemap.json",
	"--defs",
	"build/temp/globalTypes.d.luau",
	"--flag:LuauSolverV2=true",
	"src",
}, {
	cwd = process.cwd,
	env = process.env,
	stdio = "forward",
})

--luaulsp analyze --defs=build/temp/globalTypes.d.luau --sourcemap --base-luaurc=./.luaurc 