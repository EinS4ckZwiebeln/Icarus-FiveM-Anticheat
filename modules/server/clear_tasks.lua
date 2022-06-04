AddEventHandler("clearPedTasksEvent", function(sender, data)
	CancelEvent()
	TriggerEvent("anticheat:flagAsCheaterServer", sender, "ClearPedTask", false)
end)