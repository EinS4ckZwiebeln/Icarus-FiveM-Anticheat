local definedInterval = tonumber(ServerConfig.HeartbeatInterval)
local forceInclude = tonumber(ServerConfig.UntilForcedHearbeat)
local awaitedPlayers = {}
local excludedPlayers = {}

math.randomseed(os.time())
math.random(); math.random(); math.random()

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

local securityHash = RandomVariable(ServerConfig.SecurityHashLength)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(definedInterval)
		local players = GetPlayers()
		for x=1, #players do
			local serverId = tonumber(players[x])
			awaitedPlayers[serverId] = serverId
			TriggerClientEvent("transmitter:requestHeartbeat", serverId, securityHash)
		end
		Citizen.Wait(definedInterval)
		players = GetPlayers()
		for i=1, #players do
			local serverId = tonumber(players[i])
			local awaited = awaitedPlayers[serverId]
			local excluded = excludedPlayers[serverId]
			if awaited and excluded == nil then
				Citizen.CreateThread(function()
					local handler = io.popen("ping -c 1 -i 0.25 " .. tostring(GetPlayerEndpoint(serverId)))
					local response = handler:read("*a")
					local latency = string.sub(response, 107, 111)
					if latency ~= nil and latency < ServerConfig.LatencyThreshold then
						TriggerEvent("anticheat:flagAsCheaterServer", serverId, "Client failed to send heartbeat to the server", true)
						print("dropped id " .. serverId .. " due to failed heartbeat")
					else
						print("skipped id " .. serverId .. " due to (possible) connection timeout")
					end
				end)
			end
		end
	end
end)

RegisterNetEvent("heartbeat:sendAuthorization")
AddEventHandler("heartbeat:sendAuthorization", function(clientHash)
	local _source = tonumber(source)
	local _clientHash = tostring(clientHash)
	if _clientHash == securityHash then
		awaitedPlayers[_source] = nil
	end
end)

RegisterNetEvent("heartbeat:includePlayer")
AddEventHandler("heartbeat:includePlayer", function()
	local _source = tonumber(source)
	excludedPlayers[_source] = nil
end)

AddEventHandler('playerJoining', function()
	local _source = source
	excludedPlayers[_source] = _source
	Citizen.Wait(forceInclude)
	if excludedPlayers[_source] ~= nil then
		excludedPlayers[_source] = nil
		print("forced player include on id " .. _source .. " due to loading longer then ten minutes")
	end
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	excludedPlayers[_source] = nil
	awaitedPlayers[_source] = nil
end)