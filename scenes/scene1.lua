-- =============================================================
-- 12DTS Composer Example
-- https://docs.coronalabs.com/tutorial/data/jsonSaveLoad/index.html
-- =============================================================
-- Scene 1
-- =============================================================
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )
require("classes.30logglobal")
local Buttons       = require("classes.stopwatch")
local loadsaveM = require("loadsave")
local timesListM = require("timesList")
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

function scene:create( event)
    local sceneGroup = self.view
    isUserClockedIn = false
    local clockButton
    print("\nThis is the original table")
    local myData = timesListM.loadValues()
    loadsaveM.print_r(myData)
    print(myData.today)
    workedToday = display.newText("Number of hours worked today = " ..math.round((myData.today/60)/60), centerX + 80, centerY + 120, 450, 75, "LexendDeca-Regular.ttf", 14)
    workedToday:setTextColor(0,0,0,1)
    workedWeek = display.newText("Number of hours worked this week = " ..math.round((myData.thisWeek/60)/60), centerX + 80, centerY + 145, 450, 75, "LexendDeca-Regular.ttf", 14)
    workedWeek:setTextColor(0,0,0,1)
    workedMonth = display.newText("Number of hours worked this month = " ..math.round((myData.thisMonth/60)/60), centerX + 80, centerY + 170, 450, 75, "LexendDeca-Regular.ttf", 14)
    workedMonth:setTextColor(0,0,0,1)
    workedToday.align = "center"
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
