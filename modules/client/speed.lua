if not ClientConfig.Modules.Speed.enabled then
    return
end

local gTime = GetGameTimer()

function IsFacingWater(ped)
  local headPos = GetPedBoneCoords(ped, 31086, 0.0, 0.0, 0.0)
  local offsetPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 15.0, -25.0)
  local hit, hitPos = TestProbeAgainstWater(headPos.x, headPos.y, headPos.z, offsetPos.x, offsetPos.y, offsetPos.z)
  return hit, hitPos
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)
		local ped = PlayerPedId()
		local speed = GetEntitySpeed(ped)
		local coords = GetEntityCoords(ped)
		local hit, hitPos = IsFacingWater(ped)
		local threshold = ClientConfig.Modules.Speed.baseThreshold

		if IsPedInParachuteFreeFall(ped) or GetPedParachuteState(ped) > 0 or IsPedFalling(ped) then
			threshold = ClientConfig.Modules.Speed.airborneThreshold
		elseif IsPedSwimmingUnderWater(ped) or IsPedSwimming(ped) then
			threshold = ClientConfig.Modules.Speed.waterThreshold
		elseif hit or (gTime ~= nil and (GetGameTimer() - gTime) < 250) or IsEntityInAir(ped) or IsPedJumping(ped) or IsPedInMeleeCombat(ped) or IsPedStrafing(ped) or IsPedVaulting(ped) or IsPedClimbing(ped) or GetEntityHeightAboveGround(ped) > 1.1 then
			threshold = ClientConfig.Modules.Speed.miscThreshold
		end
		if speed > threshold and not IsPedInAnyVehicle(ped) and not IsPedJumpingOutOfVehicle(ped) and not IsPedRagdoll(ped) and not IsPedDeadOrDying(ped) then
			TriggerServerEvent("anticheat:flagAsCheater", "Speed", false)
			return
		end
	end
end)

AddEventHandler('gameEventTriggered', function(name, data)
	if name == "CEventNetworkEntityDamage" then
		gTime = GetGameTimer()
	end
end)