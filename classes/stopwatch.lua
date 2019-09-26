local Stopwatch = class()
Stopwatch.__name = "Buttons"
local mainGroup = display.newGroup()
----------------------
-- BEGIN SAMPLE CODE
----------------------

-- Require libraries/plugins
local widget = require( "widget" ) --
local loadsaveM = require("loadsave")
local timesListM = require("timesList")

-- Set local variables
local timeDelay = 100  -- 1/10th of a second ( 1000 milliseconds / 10 = 100 )
local timerIterations = 12000  -- Set the timer limit to 20 hours
local runMode = "stopped" -- Sets current timer mode to stopped
local startTime = 0 -- Sets the inital time to 0
local pausedAt = 0

-- Forward references
local timerText, pauseResumeButton, cancelButton, timerID


-- Called when the app's view has been resized (orientation changed)
local function onResize( event )
	pauseResumeButton.x = display.contentCenterX
	pauseResumeButton.y = display.contentHeight - 100
	cancelButton.x = display.contentCenterX
	cancelButton.y = display.contentHeight - 50
	timerText.x = display.contentCenterX - 15
end
Runtime:addEventListener( "resize", onResize )


-- Button handler function
local buttonHandler = function( event )
	if ( event.target.id == "pauseResume" ) then
		if ( runMode == "running" ) then
			runMode = "paused"
			pauseResumeButton:setLabel( "Clock Back In" )
			pausedAt = event.time
			timer.pause( timerID )
		elseif( runMode == "paused" ) then
			runMode = "running"
			pauseResumeButton:setLabel( "Take a Break" )
			timer.resume( timerID )
		elseif( runMode == "stopped" ) then
			runMode = "running"
			pauseResumeButton:setLabel( "Take a Break" )
			timerText.text = "0.0"

			timerID = timer.performWithDelay( timeDelay, timerText, timerIterations )
			startTime = 0
			pausedAt = 0
            timerText:setTextColor(0,0,0)
        end

	elseif ( event.target.id == "save" ) then
        -- Insert time to JSON file
		runMode = "stopped"
        currentHoursWorked = (((startTime - pausedAt) * 0.01 - (startTime - pausedAt) * 0.001 ) - (startTime - pausedAt) * 0.01 )
        print("current clocked time = " ..currentHoursWorked .." seconds")
        local myData = timesListM.loadValues()
        myData.today = myData.today + currentHoursWorked
        myData.thisWeek = myData.today
        myData.thisMonth = myData.thisWeek
        myData.thisYear = myData.thisMonth
        timesListM.updateValues(myData)
        loadsaveM.print_r(myData)
        pauseResumeButton:setLabel( "Start" )
		timerText.text = "0.0"
		if ( timerID ) then
			timer.cancel( timerID )
			timerID = nil
		end
		startTime = 0
		pausedAt = 0
	end
end


-- Create buttons
pauseResumeButton = widget.newButton(
	{
		id = "pauseResume",
		label = "Clock In",
        x = display.contentCenterX - 80,
		y = display.contentCenterY,
		width = 160,
		height = 45,
		font = "LexendDeca-Regular.ttf",
		fontSize = 16,
		shape = "rectangle",
		fillColor = { default={ 0.84,0.88,0.88,1 }, over={ 0,1,0,1 } },
		labelColor = { default={ 0,0,0,1 }, over={ 0,0,0,1 } },
		onRelease = buttonHandler
	})
mainGroup:insert(pauseResumeButton)

cancelButton = widget.newButton(
	{
		id = "save",
		label = "Clock Out",
		x = display.contentCenterX + 80,
		y = display.contentCenterY,
		width = 160,
		height = 45,
		font = "LexendDeca-Regular.ttf",
		fontSize = 16,
		shape = "rectangle",
		fillColor = { default={ 0.84,0.88,0.88,1 }, over={ 1,0,0,1 } },
		labelColor = { default={ 0,0,0,1 }, over={ 0,0,0,1 } },
		onRelease = buttonHandler
	})
mainGroup:insert(cancelButton)

-- In order for the right-aligned timer to display nicely, we need a font that has monospaced digits
-- Usually this is the system font and we can detect it by measuring the relative widths of the "1" and "2" characters
local bestFontForDevice = nil
local testText = display.newText( { x=-1000, y=-1000, text="1", font=native.systemFontBold, fontSize=24 } )
local width1 = testText.width
testText.text = "2"
local width2 = testText.width
display.remove(testText)

-- Create timer text object
timerText = display.newText(
	{
		parent=mainGroup,
		text="0.0",
		x=display.contentCenterX,
		y=105,
		width=310,
		font= "LexendDeca-Regular.ttf", -- ## CHANGE FONT ##
		fontSize=140,
		align="center"
	})
timerText:setFillColor(0)
display.setDefault("background", 1, 1, 1)
-- Timer function
function timerText:timer( event )

	if ( startTime == 0 ) then
		startTime = event.time
	end

	if ( pausedAt > 0 ) then
		startTime = startTime + ( event.time - pausedAt )
		pausedAt = 0
	end

	self.text = string.format( "%.1f", (event.time - startTime)/1000 )

	if ( ( event.time - startTime ) >= ( timerIterations * timeDelay ) ) then
		print( "Resetting timer..." )
		buttonHandler( { target={ id="cancel" } } )
	end
end
