if not ClientConfig.Modules.Natives.enabled then
    return
end

local natives = {
	0xCE07B9F7817AADA3,
	0x867654CBC7606F2C,
	0x96A05E4FB321B1BA,
	0x44A8FCB8ED227738,
	0xBF0FD6E56C964FCB,
	0xC5F68BE9613E2D18,
	0xE3AD2BDBAEE269AC,
	0x57FFF03E423A4C0B,
	0xA352C1B864CAFD33,
	0xFBA08C503DD5FA58,
	0x8C0D57EA686FAD87,
	0x93A3996368C94158,
	0x262B14F48D29DE80,
	0xE1EF3C1216AFF2CD,
	0xAAA34F8A7CB32098,
	0x1913FE4CBF41C463,
}

Citizen.InvokeNative = function(nativeId, ...)
	for i=1,#natives do
		if nativeId == natives[i] then
			TriggerServerEvent("anticheat:flagAsCheater", tostring(nativeId), false)
		end
	end
end