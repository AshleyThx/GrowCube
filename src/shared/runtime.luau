local runservice = game:GetService("RunService")
local ctxactionservice = game:GetService("ContextActionService")
local repstorage = game:GetService("ReplicatedStorage")

local jecs = require(repstorage.packages.jecs)
local planck = require(repstorage.packages.planck)
local jabby = require(repstorage.packages.jabby)
local rewire = require(repstorage.packages.rewire)

local world = require(repstorage.shared.world)
local scheduler = require(repstorage.shared.scheduler)
local components = require(repstorage.shared.components)
local log = require(repstorage.shared.log)

local function run(containers: {Folder}): (typeof(world))
	local reloader = rewire.HotReloader.new()
	local first_systems: {ModuleScript}? = {}
	local systems: {[ModuleScript]: planck.System<unknown>} = {}

	local function loadSystem(module: ModuleScript, ctx: {isReloading: boolean, originalModule: ModuleScript})
		local ok, system = xpcall(require, function(err)
			log.warn(`Failed to load system '{module}'\n{err}`)
		end, module)

		if ok then
			if first_systems then
				table.insert(first_systems, system)
			elseif systems[ctx.originalModule] then
				scheduler:replaceSystem(systems[ctx.originalModule] :: any, system)
				log.warn(`Reloaded system '{module}'`)
			else
				scheduler:addSystem(system)
				log.warn(`Added system '{module}'`)
			end
			systems[ctx.originalModule] = system
		end
	end
	local function unloadSystem(module: ModuleScript, ctx: {isReloading: boolean, originalModule: ModuleScript})
		if ctx.isReloading then return end

		if systems[ctx.originalModule] then
			scheduler:removeSystem(systems[ctx.originalModule] :: any)
			systems[ctx.originalModule] = nil
		end
	end

	for _, container in containers do
		(reloader :: any):scan(container, loadSystem, unloadSystem)
	end

	require(repstorage.shared.replication) --setting up replication

	if first_systems and #first_systems ~= 0 then
		scheduler:addSystems(first_systems :: any)
    end
	first_systems = nil

    if runservice:IsClient() and runservice:IsStudio() then
		local client = jabby.obtain_client()

		local function createWidget(_, state: Enum.UserInputState)
			if state ~= Enum.UserInputState.Begin then
				return
			end
			
			client.spawn_app(client.apps.home, nil)
		end

		(ctxactionservice :: any):BindAction("Open Debugger", createWidget, false, Enum.KeyCode.F4)
	end

	-- jabby.set_check_function(function(player: Player): (boolean)
	-- 	if player then
	-- 		return true
	-- 	end
	-- 	return false
	-- end)
	
	jabby.register({
		applet = jabby.applets.world,
		name = "Main",
		configuration = {
			world = world,
			get_entity_from_part = function(part: BasePart): (jecs.Id<nil>?, PVInstance?)
				for id, model in world:query(components.Model):iter() do
					if not part:IsDescendantOf(model.model) then continue end
					return id :: jecs.Id<nil>, model.model
				end
				return nil, nil
			end
		}
	})

	-- if runservice:IsServer() then
	-- 	jabby.broadcast_server()
	-- end

	return world
end
return run