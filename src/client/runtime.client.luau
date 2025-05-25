local repstorage = game:GetService("ReplicatedStorage")
local runservice = game:GetService("RunService")

_G.__DEV__ = if runservice:IsStudio() then true else false

local load_t = os.clock()

local log = require(repstorage.shared.log)

log.setup({ ExtendedTimestamp = _G.__DEV__, AllowDebugOutput = _G.__DEV__ })

log.info("Loading client runtime, logger set up", load_t)

local _ = require(repstorage.shared.runtime)({ repstorage.shared.systems, script.Parent.systems })

require(script.Parent.ui.config).createApp()

local load_end_t = os.clock()
local load_delta_t = load_end_t - load_t

log.info(("Successfully loaded client runtime in %.3fms"):format(load_delta_t * 1000))
