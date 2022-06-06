if not ClientConfig.Modules.PedBlacklist.enabled then
    return
end

local pedblacklist = ClientConfig.BlacklistedPeds

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		playerPed = PlayerPedId()
		if playerPed then
			playerModel = GetEntityModel(playerPed)
			if not prevPlayerModel then
				if isPedBlacklisted(prevPlayerModel) then
					TriggerServerEvent("anticheat:flagAsCheater", "Illegal PlayerPed [C1]", false)
				else
					prevPlayerModel = playerModel
				end
			else
				if isPedBlacklisted(playerModel) then
					TriggerServerEvent("anticheat:flagAsCheater", "Illegal PlayerPed [C2]", false)
				end
				prevPlayerModel = playerModel
			end
		end
	end
end)

function isPedBlacklisted(model)
	for _, blacklistedPed in pairs(pedblacklist) do
		if model == GetHashKey(blacklistedPed) then
			return true
		end
	end
	return false
end