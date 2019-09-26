local composer 		= require( "composer" ) -- Loads the composer libraries
local scene    		= composer.newScene()
local widget 		= require( "widget" ) -- Loads the widget libraries
require("classes.30logglobal") -- Loads the 30logglobal libraries
local Buttons       = require("classes.stopwatch") -- Loads the stopwatch libraries
local loadsaveM = require("loadsave") -- Loads the loadsave libraries
local timesListM = require("timesList") -- Loads the timeslist libraries
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
-- Constants
local fullw = display.contentWidth  -- Creates constants that help the programmer with building the UI
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

function scene:create( event)
    local sceneGroup = self.view
    local myData = timesListM.loadValues() -- Loads the timesListM table from json file
    loadsaveM.print_r(myData) -- Prints the table stored in json file to console
    workedToday = display.newText("Number of hours worked today = " ..math.round((myData.today/60)/60), centerX + 80, centerY + 120, 450, 75, "LexendDeca-Regular.ttf", 14) -- Creates text to display how many hours worked for categories
    workedToday:setTextColor(0,0,0,1) -- Sets text colour to black
    workedWeek = display.newText("Number of hours worked this week = " ..math.round((myData.thisWeek/60)/60), centerX + 80, centerY + 145, 450, 75, "LexendDeca-Regular.ttf", 14)
    workedWeek:setTextColor(0,0,0,1) -- Sets text colour to black
    workedMonth = display.newText("Number of hours worked this month = " ..math.round((myData.thisMonth/60)/60), centerX + 80, centerY + 170, 450, 75, "LexendDeca-Regular.ttf", 14)
    workedMonth:setTextColor(0,0,0,1) -- Sets text colour to black
end
---------------------------------------------------------------------------------
-- Generally Do Not Touch Below This Line
----------------------------------------------------------------------
function scene:willEnter( event )
	local sceneGroup = self.view
end
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didEnter( event )
	local sceneGroup = self.view
	local prevScene = composer.getSceneName( "previous" )
	if prevScene then
		composer.removeScene( prevScene, true )
		print("removing ", prevScene)
	end
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willExit( event )
	local sceneGroup = self.view
end
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didExit( event )
	local sceneGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:destroy( event )
	local sceneGroup = self.view
end

----------------------------------------------------------------------
--				FUNCTION/CALLBACK DEFINITIONS						--
----------------------------------------------------------------------

---------------------------------------------------------------------------------
-- Scene Dispatch Events, Etc. - Generally Do Not Touch Below This Line
---------------------------------------------------------------------------------
function scene:show( event )
	local sceneGroup 	= self.view
	local willDid 	= event.phase
	if( willDid == "will" ) then
		self:willEnter( event )
	elseif( willDid == "did" ) then
		self:didEnter( event )
	end
end
function scene:hide( event )
	local sceneGroup 	= self.view
	local willDid 	= event.phase
	if( willDid == "will" ) then
		self:willExit( event )
	elseif( willDid == "did" ) then
		self:didExit( event )
	end
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
