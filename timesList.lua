local public = {}

local loadsaveM = require("loadsave")

-- load the current values from myData.json
local myData = loadsaveM.loadTable("myData.json") or {}

public.loadValues = function ()
	-- set up defaukt values
	local timeWorked = {}
	timeWorked.today = 0
	timeWorked.thisWeek = 0
    timeWorked.thisMonth = 0
    timeWorked.thisYear = 0
	-- add default values if they do not exist
	for k, v in pairs(timeWorked) do
		myData[k] = myData[k] or v
	end
	loadsaveM.saveTable(myData, "myData.json")
	return myData
end

public.updateValues = function(myData)
	loadsaveM.saveTable(myData, "myData.json")
end

return public
