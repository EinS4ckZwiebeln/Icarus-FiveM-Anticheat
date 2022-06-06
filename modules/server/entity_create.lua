if not ServerConfig.Modules.EntityCreate.enabled then
    return
end

function isIllegalModel(modelHash)
	local models = ServerConfig.IllegalModels 
	for i=1, #models do
		if modelHash == GetHashKey(models[i]) then
			return true
		end
	end
	return false
end

AddEventHandler("entityCreated", function(handle)
    local model = GetEntityModel(handle)
    local owner = NetworkGetFirstEntityOwner(handle)

    if isIllegalModel(model) and owner > 0 then
        TriggerEvent("anticheat:flagAsCheaterServer", owner, "Illegal Entity Model", false)
        DeleteEntity(handle)
    end
end)

if ServerConfig.Modules.EntityCreate.scriptOwnership then
    AddEventHandler("entityCreating", function(handle)
        local script = GetEntityScript(handle)
        if script == nil then
            return
        end

        for i=0, GetNumResources() - 1 do
            local rName = GetResourceByFindIndex(i)
            if rName == script then
                return
            end
        end

        local owner = NetworkGetFirstEntityOwner(handle)
        if owner > 0 then
            TriggerEvent("anticheat:flagAsCheaterServer", owner, "Illegal Entity Ownership", false)
            CancelEvent()
        end
    end)
end