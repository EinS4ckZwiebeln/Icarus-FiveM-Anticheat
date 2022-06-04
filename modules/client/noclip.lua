local loaded = false
local rayFlagsLocation = 1
local rayFlagsObstruction = 273

AddEventHandler('playerSpawned', function()
	Citizen.Wait(15000)
	loaded = true
end)

AddEventHandler('playerDropped', function (reason)
	loaded = false
end)

function legitVehicleClass(vehicle)
	local class = GetVehicleClass(vehicle)
	local forbiddenClasses = { 19, 18, 16, 15, 14}
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
		local handle = GetEntityAttachedTo(ped)
		local isHandlePlayer = IsPedAPlayer(handle)
		local vehicle = GetVehiclePedIsIn(ped)

		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(100)
		end
		
		if IsPedFalling(ped) == false and IsPedRagdoll(ped) == false and IsPedDeadOrDying(ped) == false and IsPedSwimming(ped) == false and IsPedSwimmingUnderWater(ped) == false and IsPedInParachuteFreeFall(ped) == false and GetPedParachuteState(ped) == -1 and legitVehicleClass(vehicle) == false and IsPedClimbing(ped) == false and GetEntityHeightAboveGround(ped) > 8.0 and (isHandlePlayer == false or isHandlePlayer == nil) then
			if not (IsPedInAnyVehicle(ped) and IsVehicleOnAllWheels(vehicle) == false) then
				local rays = {[1] = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -8.0), [2] = GetOffsetFromEntityInWorldCoords(ped, 8.0, 0.0, -8.0), [3] = GetOffsetFromEntityInWorldCoords(ped, 8.0, 8.0, -8.0), [4] = GetOffsetFromEntityInWorldCoords(ped, -8.0, 0.0, -8.0), [5] = GetOffsetFromEntityInWorldCoords(ped, -8.0, -8.0, -8.0), [6] = GetOffsetFromEntityInWorldCoords(ped, -8.0, 8.0, -8.0), [7] = GetOffsetFromEntityInWorldCoords(ped, 0.0, 8.0, -8.0), [8] = GetOffsetFromEntityInWorldCoords(ped, 0.0, -8.0, -8.0), [9] = GetOffsetFromEntityInWorldCoords(ped, 8.0, -8.0, -8.0)}

				for i = 1, #rays do
    				local testRay = StartShapeTestRay(origin, rays[i], rayFlagsLocation, ped, 7)
    				local _, hit, hitLocation, surfaceNormal, material, _ = GetShapeTestResultEx(testRay)
					--DrawMarker(0, rays[i].x, rays[i].y, rays[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 10, 10, 100, false, true, 2, false, false, false, false)
					if hit == 0 then
						count = count + 1
					else
						count = 0
					end
				end
				if count >= (3 * #rays) then
					TriggerServerEvent("anticheat:flagAsCheater", "NoClip", false)
					return
				end
			end
		end
	end
end)