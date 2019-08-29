local public = {}

local loadsaveM = require("loadsave")

-- load the current values from myData.json
local myData = loadsaveM.loadTable("myData.json") or {}

public.loadValues = function ()
	-- set up defaukt values
	local timeWorked = {}
	timeWorked.today = 3
	timeWorked.thisWeek
    timeWorked.thisMonth



	-- add default values if they do not exist
	for k, v in pairs(defaultSettings) do
		myData[k] = myData[k] or v
	end
	loadsaveM.saveTable(myData, "myData.json")
	return myData
end

public.updateValues = function(myData)
	loadsaveM.saveTable(myData, "myData.json")
end

return public
