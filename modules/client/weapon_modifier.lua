if not ClientConfig.Modules.WeaponModifier.enabled then
    return
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local pId = PlayerPedId()
		if GetPlayerWeaponDamageModifier(pId) > 1.0 then
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal WeaponModifier", false)
			return
		end
		if GetPlayerMeleeWeaponDamageModifier(pId) > 1.0 then
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal WeaponModifier", false)
			return
		end
		if GetPlayerMeleeWeaponDefenseModifier(pId) > 1.0 then
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal WeaponModifier", false)
			return
		end
		if GetPlayerWeaponDefenseModifier(pId) > 1.0 then
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal WeaponModifier", false)
			return
		end
		if GetPlayerWeaponDefenseModifier_2(pId) > 1.0 then
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal WeaponModifier", false)
			return
		end
	end

end)