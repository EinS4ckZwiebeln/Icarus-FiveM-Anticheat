local validResourceList

local function collectValidResourceList()
    validResourceList = {}
    for i=0, GetNumResources() - 1 do
        validResourceList[GetResourceByFindIndex(i)] = true
    end
end

collectValidResourceList()

AddEventHandler("onResourceListRefresh", collectValidResourceList)

RegisterNetEvent("anticheat:rcheck")
AddEventHandler("anticheat:rcheck", function(id, givenList)
    for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
            TriggerEvent("anticheat:flagAsCheaterServer", id, "Injected Resource", false)
            break
        end
    end
end)