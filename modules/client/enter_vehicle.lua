AddEventHandler('gameEventTriggered', function(name, data)
	if name == "CEventNetworkPlayerEnteredVehicle" then
        local vehicle = data[2]
        if DoesEntityExist(vehicle) then

            if IsEntityUpsidedown(vehicle) then
                TriggerServerEvent("anticheat:flagAsCheater", "Vehicle Teleport [C1]", false)
            end

            if GetEntitySpeed(vehicle) * 3.6 > 40 then
                TriggerServerEvent("anticheat:flagAsCheater", "Vehicle Teleport [C2]", false)
            end
        end
	end
end)