local loaded = false
local totalDamageEvents = 0
local totalHeadshots = 0

AddEventHandler('playerSpawned', function()
	Citizen.Wait(15000)
	loaded = true
end)

AddEventHandler('playerDropped', function (reason)
	loaded = false
end)

Citizen.CreateThread(function()
	while not loaded do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(5000)
		SetPlayerTargetingMode(0)
	end
end)

--[[
local lines = {}
local lines2 = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i = 1, #lines do
			local a = lines[i]
			for i = 1, #lines2 do
				local b = lines2[i]
				DrawLine(a.x, a.y, a.z, b.x, b.y, b.z, 255, 0, 0, 255)
			end
		end
		if IsControlJustReleased(1, 46) then
			local c = GetEntityCoords(GetPlayerPed(-1))
			local modelHash = GetHashKey("g_m_y_ballasout_01")
			RequestModel(modelHash)
			while not HasModelLoaded(modelHash) do
				Citizen.Wait(1)
			end
			local ped = CreatePed(0, modelHash , c.x, c.y, c.z - 1, rot, true, true)
			FreezeEntityPosition(ped, true)
		end
	end
end)

--]]

local rayFlagsLocation = 1
local rayFlagsObstruction = 273
local count = 0

function isBadHash(hash)
	local hashes = { 3058715602, 286056380, 3357909247, 4233768403, 798856618, 428159217, 3280748971, 2462366525, 3779253713, 2820610173, 1693512364, 1436779599, 1114654932, 2557052034}
	for i=1, #hashes do
		if hashes[i] == hash then
			return true
		end
	end
	return false
end

AddEventHandler('gameEventTriggered', function(name, data)
	if name == "CEventNetworkEntityDamage" then
		local targetEntity = data[1]
		local ped = data[2]
		local hash = data[3]

		if (IsEntityAPed(targetEntity) or IsPedAPlayer(targetEntity)) and IsPedAPlayer(ped) and not IsPedDeadOrDying(targetEntity) and isBadHash(hash) == false then
			local camcoords = GetFinalRenderedCamCoord()
			local _, bone = GetPedLastDamageBone(targetEntity)
			local rays = {[1] = camcoords, [2] = vec3(camcoords.x, camcoords.y, camcoords.z + 2.5), [3] = GetOffsetFromEntityInWorldCoords(ped, 2.5, 1.5, 0.8), [4] = GetOffsetFromEntityInWorldCoords(ped, -2.5, 1.5, 0.8)}
			local dest = GetPedBoneCoords(targetEntity, bone, 0.0, 0.0, 0.0)

			for i = 1, #rays do
    			local testRay = StartShapeTestRay(rays[i], dest, rayFlagsLocation, ped, 7)
    			local _, hit, hitLocation, surfaceNormal, material, _ = GetShapeTestResultEx(testRay)
				--[[lines[#lines + 1] = rays[i]
				lines2[#lines2 + 1] = dest --]]

				if hit == 1 then
					local threshold = GetDistanceBetweenCoords(dest, hitLocation)
					if threshold > 5.0 then
						count = count + 1
					end
				else
					count = 0
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if count >= (3 * 4) then
			TriggerServerEvent("anticheat:flagAsCheater", "Aimbot [C1]", false)
			return
		end
	end
end)

AddEventHandler('gameEventTriggered', function(name, data)
	if name == "CEventNetworkEntityDamage" then
		local ped = data[2]
		local hash = data[3]
		local headshot = data[11] --headshot?

		if (IsEntityAPed(targetEntity) or IsPedAPlayer(targetEntity)) and IsPedAPlayer(ped) and isBadHash(hash) == false then
			totalDamageEvents = totalDamageEvents + 1
			if headshot == 1 then
				totalHeadshots = totalHeadshots + 1
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if totalDamageEvents > 16 then
			local percentage = (totalHeadshots / totalDamageEvents)
			if percentage > 0.8 then
				TriggerServerEvent("anticheat:flagAsCheater", "Aimbot [C2]", false)
				return
			end
		end
		if totalDamageEvents > 256 then
			totalDamageEvents = 0
			totalHeadshots = 0
		end
	end
end)