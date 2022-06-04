AddEventHandler("giveWeaponEvent", function(source, data)
	source = tonumber(source)
	local entity = NetworkGetEntityFromNetworkId(data.pedId)
	if DoesEntityExist(entity) then
		local owner = NetworkGetEntityOwner(entity)
		if owner ~= source then
			TriggerEvent("anticheat:flagAsCheaterServer", source, "GiveWeapon", false)
			CancelEvent()
		end
	end
end)