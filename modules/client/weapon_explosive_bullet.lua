Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local ped = GetPlayerPed(-1)
        local weaponDamage = GetWeaponDamageType(GetSelectedPedWeapon(ped))
		if weaponDamage == 4 or weaponDamage == 5 or weaponDamage == 6 or weaponDamage == 13 then
			TriggerServerEvent("anticheat:flagAsCheater", "Explosive Bullet", false)
			return
		end
	end
end)