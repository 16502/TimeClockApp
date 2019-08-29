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
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

function scene:create( event )
    ----------------------------------------------------------------------
    -- Stopwatch
    ----------------------------------------------------------------------
    ----------------------------------------------------------------------
    -- Clock In and Button
    ----------------------------------------------------------------------
	local sceneGroup = self.view
    isUserClockedIn = false
    local clockButton

    --
    -- local function handleButtonClockIn( event )
    --     if (isUserClockedIn == false) then
    --         isUserClockedIn = true
    --         clockButton:setLabel("Clock Out")
    --     elseif (isUserClockedIn == true) then
    --         isUserClockedIn = false
    --         clockButton:setLabel("Clock In")
    --     end
    -- end
    -- clockButton = widget.newButton(
    --     {
    --         label = "",
    --         onRelease = handleButtonClockIn,
    --         emboss = false,
    --         shape = "roundedRect",
    --         width = 300,
    --         height = 75,
    --         cornerRadius = 2,
    --         fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
    --         strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
    --         strokeWidth = 4
    --     }
    -- )
    -- sceneGroup:insert(clockButton)
    -- clockButton.x = centerX
    -- clockButton.y = centerY - 150
    -- if isUserClockedIn == false then
    --     clockButton:setLabel("Clock In")
    -- elseif isUserClockedIn == true then
    --     clockButton:setLabel("Clock Out")
    -- end
    ----------------------------------------------------------------------
    -- Time Storage
    ----------------------------------------------------------------------
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
