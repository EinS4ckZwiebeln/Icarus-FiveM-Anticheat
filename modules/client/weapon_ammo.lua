local bullets = nil
local totalBullets = nil
local ped = nil
local inVehicle = nil
local attached = nil
local gTime = GetGameTimer()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		ped = GetPlayerPed(-1)		
		inVehicle = IsPedInAnyVehicle(ped)
		attached = IsEntityAttachedToEntity(ped)
	end
end)

Citizen.CreateThread(function()
	while ped == nil do
		Citizen.Wait(0)
	end
	while true do
		Citizen.Wait(5000)
		local weaponHash = GetSelectedPedWeapon(ped)
		local _, maxAmmo = GetMaxAmmo(ped, weaponHash)
		local maxAmmoClip = GetMaxAmmoInClip(ped, weaponHash, 1)
		local ammoInWeapon = GetAmmoInPedWeapon(ped, weaponHash)
		local hasAmmo, ammoInClip = GetAmmoInClip(ped, weaponHash)
		local ammoClipSize = GetWeaponClipSize(weaponHash)

		if ammoInWeapon > maxAmmo + 1 then --more than 9999 bullets in weapon
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal Ammunition Size [C1]", false)
			return
		elseif hasAmmo and ammoInClip > maxAmmoClip + 1 then --more ammo in clip than clip capacity offers
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal Ammunition Size [C2]", false)
			return
		elseif ammoInWeapon < 0 or ammoInClip < 0 then -- negative ammo in clip or in weapon
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal Ammunition Size [C3]", false)
			return
		elseif maxAmmo < 0 or ammoClipSize < 0 or maxAmmoClip < 0 then -- negative maxammo and clipsize
			TriggerServerEvent("anticheat:flagAsCheater", "Illegal Ammunition Size [C4]", false)
			return
		end
	end
end)

function isBadHash(hash)
	local hashes = { 911657153, 1198879012, 101631238, 883325847, 1834241177, 1198256469, -1238556825, -1355376991, -1168940174, -72657034}
	for i=1, #hashes do
		if hashes[i] == hash then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	while ped == nil do
		Citizen.Wait(0)
	end
	while true do
		Citizen.Wait(0)	
		if IsPedReloading(ped) or IsPedSwappingWeapon(ped) then
			bullets = nil
			totalBullets = nil
		end
		if IsPedShooting(ped) and not inVehicle and not attached then --armed vehcile?
			local weaponHash = GetSelectedPedWeapon(ped)
			local hasAmmo, ammoInClip = GetAmmoInClip(ped, weaponHash)
			local ammoInWeapon = GetAmmoInPedWeapon(ped, weaponHash)
			local badHash = isBadHash(weaponHash)
			if not badHash and hasAmmo and ammoInClip ~= 0 and ammoInClip == GetMaxAmmoInClip(ped, weaponHash, 1) then
				TriggerServerEvent("anticheat:flagAsCheater", "Infinite Ammunition [C1]", false)
				return
			end
			if not badHash and bullets ~= nil and ammoInClip >= bullets then
				TriggerServerEvent("anticheat:flagAsCheater", "Infinite Ammunition [C2]", false)
				return
			elseif not badHash and totalBullets ~= nil and (GetGameTimer() - gTime) < 200 and ammoInWeapon >= totalBullets then
				TriggerServerEvent("anticheat:flagAsCheater", "Infinite Ammunition [C3]", false)
				return
			end
			gTime = GetGameTimer()
			bullets = ammoInClip
			totalBullets = ammoInWeapon
		end
	end
end)