if not ClientConfig.Modules.NoClip.enabled then
    return
end

local loaded = false
local rayFlagsLocation = ClientConfig.Modules.NoClip.rayFlag

AddEventHandler("playerSpawned", function()
	Citizen.Wait(15000)
	loaded = true
end)

AddEventHandler("playerDropped", function (reason)
	loaded = false
end)

function legitVehicleClass(vehicle)
	local class = GetVehicleClass(vehicle)
	local forbiddenClasses = ClientConfig.Modules.NoClip.vehicleClasses
	for i=1, #forbiddenClasses do
		if class == forbiddenClasses[i] then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	local count = 0
	while not loaded do
		Citizen.Wait(100)
	end
	while true do
		Citizen.Wait(500)
		local ped = PlayerPedId()
    	local playerCoord = GetEntityCoords(ped)
		local origin = vec3(playerCoord.x, playerCoord.y, playerCoord.z + 0.5)
		local vehicle = GetVehiclePedIsIn(ped)

		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(100)
		end
		
		if not IsPedFalling(ped) and not IsPedRagdoll(ped) and not IsPedDeadOrDying(ped) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) and not IsPedInParachuteFreeFall(ped) and GetPedParachuteState(ped) == -1 and not legitVehicleClass(vehicle) and not IsPedClimbing(ped) and GetEntityHeightAboveGround(ped) > 8.0 and not IsEntityAttachedToAnyPed(ped) then
			if not (IsPedInAnyVehicle(ped) and not IsVehicleOnAllWheels(vehicle)) then
				local rays = {[1] = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -8.0), [2] = GetOffsetFromEntityInWorldCoords(ped, 8.0, 0.0, -8.0), [3] = GetOffsetFromEntityInWorldCoords(ped, 8.0, 8.0, -8.0), [4] = GetOffsetFromEntityInWorldCoords(ped, -8.0, 0.0, -8.0), [5] = GetOffsetFromEntityInWorldCoords(ped, -8.0, -8.0, -8.0), [6] = GetOffsetFromEntityInWorldCoords(ped, -8.0, 8.0, -8.0), [7] = GetOffsetFromEntityInWorldCoords(ped, 0.0, 8.0, -8.0), [8] = GetOffsetFromEntityInWorldCoords(ped, 0.0, -8.0, -8.0), [9] = GetOffsetFromEntityInWorldCoords(ped, 8.0, -8.0, -8.0)}

				for i = 1, #rays do
    				local testRay = StartShapeTestRay(origin, rays[i], rayFlagsLocation, ped, 7)
    				local _, hit, _, _, _, _ = GetShapeTestResultEx(testRay)

					if hit == 0 then
						count = count + 1
					else
						count = 0
					end
				end
				if count >= (ClientConfig.Modules.NoClip.failedHits * #rays) then
					TriggerServerEvent("anticheat:flagAsCheater", "NoClip", false)
					return
				end
			end
		end
	end
end)