-- =============================================================
-- main.lua
-- =============================================================

----------------------------------------------------------------------
--	1. Requires
----------------------------------------------------------------------
-- http://docs.coronalabs.com/daily/api/library/composer/index.html
local composer 	= require "composer" 


----------------------------------------------------------------------
--	2. Initialization
----------------------------------------------------------------------
-- Turn on debug output for composer + Various other settings
--
composer.isDebug = true

composer.gotoScene( "scenes.scene1" )	
