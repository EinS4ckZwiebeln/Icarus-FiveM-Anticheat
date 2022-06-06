if not ServerConfig.Modules.ClearTasks.enabled then
    return
end

AddEventHandler("clearPedTasksEvent", function(sender, data)
	CancelEvent()
	TriggerEvent("anticheat:flagAsCheaterServer", sender, "ClearPedTask", false)
end)