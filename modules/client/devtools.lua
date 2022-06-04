RegisterNUICallback('devtoolOpening', function()
    Citizen.Wait(1500)
    TriggerServerEvent("anticheat:flagAsCheater", "NUI DevTools", false)
end)