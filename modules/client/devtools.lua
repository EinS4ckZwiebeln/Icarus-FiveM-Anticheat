if not ClientConfig.Modules.DevTools.enabled then
    return
end

RegisterNUICallback('devtoolOpening', function()
    Citizen.Wait(1500)
    TriggerServerEvent("anticheat:flagAsCheater", "NUI DevTools", false)
end)