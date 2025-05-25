type LogLevel = {
	RobloxLevel: Enum.AnalyticsLogLevel,
}

local LOG_LEVELS = {
	TRACE = {
		RobloxLevel = Enum.AnalyticsLogLevel.Trace,
	},
	DEBUG = {
		RobloxLevel = Enum.AnalyticsLogLevel.Debug,
	},
	INFO = {
		RobloxLevel = Enum.AnalyticsLogLevel.Information,
	},
	ERROR = {
		RobloxLevel = Enum.AnalyticsLogLevel.Error,
	},
	FATAL = {
		RobloxLevel = Enum.AnalyticsLogLevel.Fatal,
	},
	WARNING = {
		RobloxLevel = Enum.AnalyticsLogLevel.Warning,
	},
}

local logger = {
	_config = {
		extended_timestamp = false,
		allow_debug = false,
	},
}

local function formatLog(level: string, text: string, timestamp: number)
	local cur_time = DateTime.fromUnixTimestampMillis(timestamp)

	local timestamp_text = if logger._config.extended_timestamp
		then cur_time:FormatUniversalTime("MM.DD.YY HH:mm:ss-SSS", "en-us")
		else cur_time:FormatUniversalTime("HH:mm:ss", "en-us")

	return ("[%s] [%s]: %s"):format(timestamp_text, level, text)
end

local function logRobloxConsole(log_level: LogLevel, log: string)
	local log_analytics_level = log_level.RobloxLevel
	if
		log_analytics_level == Enum.AnalyticsLogLevel.Error
		or log_analytics_level == Enum.AnalyticsLogLevel.Fatal
		or log_analytics_level == Enum.AnalyticsLogLevel.Warning
	then
		warn(log)
	else
		print(log)
	end
	--TODO: figure out how to output different levels like Luarmor
end

local function logText(level: keyof<typeof(LOG_LEVELS)>, text: string, timestamp: number?)
	timestamp = timestamp or DateTime.now().UnixTimestampMillis

	assert(typeof(level) == "string", "Invalid argument #1, string expected")
	assert(typeof(text) == "string", "Invalid argument #2, string expected")
	assert(typeof(timestamp) == "number" or timestamp == nil, "Invalid argument #3, number or nil expected")

	local level_enum = LOG_LEVELS[level]
	assert(level_enum, `No log level {level} found`)

	local log_text = formatLog(level, text, timestamp)

	if level ~= "DEBUG" or logger._config.allow_debug then pcall(logRobloxConsole, level_enum, log_text) end

	return log_text
end

local function logtrace(text: string, timestamp: number?)
	return logText("TRACE", text, timestamp)
end
local function logdebug(text: string, timestamp: number?)
	return logText("DEBUG", text, timestamp)
end
local function loginfo(text: string, timestamp: number?)
	return logText("INFO", text, timestamp)
end
local function logfatal(text: string, timestamp: number?)
	return logText("FATAL", text, timestamp)
end
local function logwarn(text: string, timestamp: number?)
	return logText("WARNING", text, timestamp)
end
local function logerror(text: string, timestamp: number?)
	return logText("ERROR", text, timestamp)
end

local function setupLogger(config: {
	ExtendedTimestamp: boolean?,
	AllowDebugOutput: boolean?,
})
	assert(typeof(config) == "table", "Invalid argument #1, table expected")
	assert(
		typeof(config.ExtendedTimestamp) == "boolean" or config.ExtendedTimestamp == nil,
		"Invalid 'ExtendedTimestamp', boolean or nil expected"
	)
	assert(
		typeof(config.AllowDebugOutput) == "boolean" or config.AllowDebugOutput == nil,
		"Invalid 'AllowDebugOutput', boolean or nil expected"
	)

	logger._config.extended_timestamp = config.ExtendedTimestamp or logger._config.extended_timestamp
	logger._config.allow_debug = config.AllowDebugOutput or logger._config.allow_debug

	return logger
end

logger.trace = logtrace
logger.debug = logdebug
logger.info = loginfo
logger.fatal = logfatal
logger.warn = logwarn
logger.error = logerror

logger.setup = setupLogger

return logger
