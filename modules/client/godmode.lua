if not ClientConfig.Modules.Godmode.enabled then
    return
end

local loaded = false
local hadArmor = false

AddEventHandler('playerSpawned', function()
	Citizen.Wait(15000)
	loaded = true
end)

AddEventHandler('playerDropped', function (reason)
	loaded = false
end)

Citizen.CreateThread(function()
	while not loaded do
		Citizen.Wait(100)
	end
	while true do
		Citizen.Wait(15000)
		local ped = PlayerPedId()
		local initHealth = GetEntityHealth(ped)
		local rVal = ClientConfig.Modules.Godmode.decrement
		local modified = (initHealth - rVal)

		SetEntityHealth(ped, modified)
		local toWait = ClientConfig.Modules.Godmode.wait
		Citizen.Wait(toWait)
		ped = PlayerPedId()
		local postHealth = GetEntityHealth(ped)
		if postHealth > modified and postHealth > 0 and not IsPedDeadOrDying(ped) then
			TriggerServerEvent("anticheat:flagAsCheater", "Godmode [C1]", false)
			return
		else
			SetEntityHealth(ped, postHealth + rVal)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = PlayerPedId()
		local pedArmor = GetPedArmour(ped)
		if pedArmor > 0 then
			hadArmor = true
		else
			hadArmor = false
		end
	end
end)

AddEventHandler('gameEventTriggered', function(name, data)
	if name == "CEventNetworkEntityDamage" then
		local targetEntity = data[1]
		local ped = data[2]
		local isMelee = data[12]
		if IsPedAPlayer(targetEntity) and targetEntity == PlayerPedId() then
			ped = targetEntity
			local pedHealth = GetEntityHealth(ped)
			local pedArmor = GetPedArmour(ped)
			if pedHealth >= 200 and pedArmor <= 0 and not hadArmor then
				TriggerServerEvent("anticheat:flagAsCheater", "Godmode [C2]", false)
				return
			elseif pedArmor >= 100 and isMelee == 0 and not IsEntityOnFire(ped) then
				TriggerServerEvent("anticheat:flagAsCheater", "Godmode [C3]", false)
				return
			end
			if pedArmor > 0 then
				hadArmor = true
			else
				hadArmor = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local ped = PlayerPedId()
		local pedHealth = GetEntityHealth(ped)
		local maxHealth = GetEntityMaxHealth(ped)
		local pedArmor = GetPedArmour(ped)

		if pedHealth > ClientConfig.Modules.Godmode.maxHealth then
			TriggerServerEvent("anticheat:flagAsCheater", "Godmode [C4]", false)
			return
		elseif maxHealth > ClientConfig.Modules.Godmode.maxHealth then
			TriggerServerEvent("anticheat:flagAsCheater", "Godmode [C5]", false)
			return
		elseif pedArmor > ClientConfig.Modules.Godmode.maxArmor then
			TriggerServerEvent("anticheat:flagAsCheater", "Godmode [C6]", false)
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if GetPlayerInvincible_2(ped) or GetEntityCanBeDamaged(ped) == false then
			if IsPedShooting(ped) or IsPedInCombat(ped) then
				TriggerServerEvent("anticheat:flagAsCheater", "Godmode [C7]", false)
				return
			end
		end
	end
end)