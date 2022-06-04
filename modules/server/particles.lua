AddEventHandler("ptFxEvent", function(source, data)
	source = tonumber(source)
	local entityNetId = data[4]
	local entity = NetworkGetEntityFromNetworkId(entityNetId)

	if DoesEntityExist(entity) then
		local owner = NetworkGetEntityOwner(entity)
		if owner ~= source then
			TriggerEvent("anticheat:flagAsCheaterServer", source, "ptFxEvent [C1]", false)
			CancelEvent()
		end
	end

	local scale = tonumber(data[24])
	if scale ~= nil and scale > 10.0 then
		TriggerEvent("anticheat:flagAsCheaterServer", source, "ptFxEvent [C2]", false)
		CancelEvent()
	end
end)