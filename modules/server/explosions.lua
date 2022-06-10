if not ServerConfig.Modules.ExplosionFilter.enabled then
    return
end

function isIllegalType(type)
	local types = ServerConfig.IllegalExplosionTypes
	for i=1, #types do
		if type == types[i] then
			return true
		end
	end
	return false
end

AddEventHandler("explosionEvent", function(sender, event)
    sender = tonumber(sender)
    local scale = event.damageScale
    local type = event.explosionType
    local invisible = event.isInvisible

    if isIllegalType(type) then
        TriggerEvent("anticheat:flagAsCheaterServer", sender, "Explosion Event [C1]", false)
    elseif scale > 1.0 then
        TriggerEvent("anticheat:flagAsCheaterServer", sender, "Explosion Event [C2]", false)
    elseif invisible then
        TriggerEvent("anticheat:flagAsCheaterServer", sender, "Explosion Event [C3]", false)     
    end
end)