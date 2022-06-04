Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
        if NetworkIsInSpectatorMode() then
			TriggerServerEvent("anticheat:flagAsCheater", "Spectator", false)
			return
        end
	end
end)