local triggers = {}

AddEventHandler("startProjectileEvent", function(source, data)
	source = tonumber(source)
	if triggers[source] ~= nil then
		triggers[source] = triggers[source] + 1
	else
		triggers[source] = 1
	end
end)

-- big wip
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
		for i=1, #triggers do
			if triggers[i] > 18 then
				TriggerEvent("anticheat:flagAsCheaterServer", tonumber(i), "Projectile Spammer", true)
			end
			triggers[i] = 0
		end
	end
end)