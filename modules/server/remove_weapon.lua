AddEventHandler("removeWeaponEvent", function(source, data)
	source = tonumber(source)
	local entity = NetworkGetEntityFromNetworkId(data.pedId)
	if DoesEntityExist(entity) then
		local owner = NetworkGetEntityOwner(entity)
		if owner ~= source then
			TriggerEvent("anticheat:flagAsCheaterServer", source, "RemoveWeapon", false)
			CancelEvent()
		end
	end
end)

AddEventHandler("removeAllWeaponsEvent", function(source, data)
	source = tonumber(source)
	local entity = NetworkGetEntityFromNetworkId(data.pedId)
	if DoesEntityExist(entity) then
		local owner = NetworkGetEntityOwner(entity)
		if owner ~= source then
			TriggerEvent("anticheat:flagAsCheaterServer", source, "RemoveAllWeapons", false)
			CancelEvent()
		end
	end
end)