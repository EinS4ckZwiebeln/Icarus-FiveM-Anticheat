Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local ped = GetPlayerPed(-1)
		for i=1,#ClientConfig.BlacklistedWeapons do
			if(HasPedGotWeapon(ped, GetHashKey(ClientConfig.BlacklistedWeapons[i]), false) == 1) then
				TriggerServerEvent("anticheat:flagAsCheater", "Illegal Weapon", false)
				return
			end
		end
	end
end)