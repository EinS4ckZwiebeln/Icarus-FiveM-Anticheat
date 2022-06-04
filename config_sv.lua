ServerConfig = {}

ServerConfig.BypassAcePerm = "icarus.bypass"

ServerConfig.DiscordWebhook = ""

-- Add your own ban logic here
function issueBan(source, reason)
	local _source = tonumber(source)
	TriggerEvent("EasyAdmin:banPlayer", source, "Cheating (" .. reason .. ")", 1044463300) -- EasyAdmin for the sake of simplicity
end

-- Server to client heartbeat settings
-- Do not touch if you have no clue what you are doing!
ServerConfig.LatencyThreshold = 1000 -- ms

ServerConfig.HeartbeatInterval = 30000 -- Time it takes to request a heartbeat from the client (actual time is 2x of this value)

ServerConfig.UntilForcedHearbeat = (10 * 60000) -- Ten minutes

ServerConfig.SecurityHashLength = 16 -- The char length of the security hash which is used to verify heartbeats
