function flagAsCheater(source, reason, kick)
	local _source = tonumber(source)
	if not IsPlayerAceAllowed(_source, ServerConfig.BypassAcePerm) then
		local _reason = tostring(reason)
		collectData(_source, reason)
		Citizen.Wait(500)
		local _kick = kick
		if kick then
			DropPlayer(_source, _reason)
		else
			issueBan(_source, reason)
		end
	end
end

function collectData(source, reason)
	local ped = GetPlayerPed(source)
	local ip = GetPlayerEndpoint(source)
	local name = GetPlayerName(source)
	local ping = GetPlayerPing(source)

    local steamid = nil
    local license = nil

  	for k,v in pairs(GetPlayerIdentifiers(source)) do
      		if string.sub(v, 1, string.len("steam:")) == "steam:" then
        		steamid = tostring(v)
      		elseif string.sub(v, 1, string.len("license:")) == "license:" then
        		license = tostring(v)
      		end
  	end

	if steamid == nil then
		steamid = "N/A"
	elseif license == nil then
		license = "N/A"
	elseif name == nil then
		name = "N/A"
	end

	local data = {{["color"] = "2554368", ["title"] = "Player Banned (" .. reason .. ")", ["description"] = "**IP Adress**: " .. ip .. "\n**FiveM**: " .. license .. "\n**SteamID**: " .. steamid .. "\n**Name**: " .. name .. "\n**Ping**: " .. ping .. "ms", ["footer"] = {["text"] = communityname, ["icon_url"] = communtiylogo}}}
	local logs = ServerConfig.DiscordWebhook
    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Data Collector", embeds = data}), { ['Content-Type'] = 'application/json' })

	local rState = GetResourceState("screenshot-basic")
	if rState == "stopped" or rState == "stopping" or rState == "uninitialized" then
		StartResource("screenshot-basic")
		Citizen.Wait(30000)
	end
	if rState == "started" then
		TriggerClientEvent("transmitter:requestScreenshot", source, logs)
	end
end

RegisterNetEvent("anticheat:flagAsCheater")
AddEventHandler("anticheat:flagAsCheater", function(reason, kick)
	local _source = tonumber(source)
	local _reason = tostring(reason)
	flagAsCheater(_source, _reason, kick)
end)

RegisterNetEvent("anticheat:flagAsCheaterServer")
AddEventHandler("anticheat:flagAsCheaterServer", function(sender, reason, kick)
	local _source = tonumber(sender)
	local _reason = tostring(reason)
	flagAsCheater(_source, _reason, kick)
end)