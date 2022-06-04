RegisterNetEvent('transmitter:requestHeartbeat')
AddEventHandler('transmitter:requestHeartbeat', function(securityHash)
	local clientHash = tostring(securityHash)
	if (clientHash == nil or clientHash == "") then
		print("server failed to transmit security hash")
	else
		TriggerServerEvent("heartbeat:sendAuthorization", clientHash)
		while NetworkGetAveragePacketLossForPlayer(PlayerId()) > 0.1 do
			TriggerServerEvent("heartbeat:sendAuthorization", clientHash)
			print("resending heartbeat due to high packet loss on client...")
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('transmitter:requestScreenshot')
AddEventHandler('transmitter:requestScreenshot', function(url)
	local _url = url
	if url ~= nil then
		exports['screenshot-basic']:requestScreenshotUpload(tostring(url), "files[]", function(data)
			if data == nil then
				print("fatal error while requesting screenshot")
			end
		end)
	end
end)

AddEventHandler('playerSpawned', function()
	TriggerServerEvent("heartbeat:includePlayer")
end)