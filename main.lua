require "CiderDebugger";
local physics = require("physics")
local player = require("scripts.Player")
local ball = require("scripts.Ball")
local touchController = require("scripts.TouchController")
local trackingController = require("scripts.TrackingController")

local halfH = display.contentHeight / 2
local halfW = display.contentWidth / 2

local leftScore = nil
local rightScore = nil
local localBall = nil

local function resetBall()
    localBall.x = halfW
    localBall.y = halfH
end

local function initializePhysics()
	physics.start()
	--physics.setDrawMode("hybrid")
	physics.setGravity(0, 0)
	
	local top = display.newRect(0, 0, display.contentWidth +1, 4)
	local bottom = display.newRect(0, display.contentHeight -4, display.contentWidth +1, 4)
	local attributes = { friction = 0, bounce = 1.0 }
	
	physics.addBody(top, attributes)
	physics.addBody(bottom, attributes)

	-- You have to specify "static" after you added the body...
	top.bodyType = "static"
	bottom.bodyType = "static"
	
	local leftLimit = display.newRect(0, 0, 5, display.contentHeight)
	leftLimit.isVisible = false
	leftLimit.collision = function(object, event)
            if event.phase == "ended" then
		rightScore.score = rightScore.score +1
        	rightScore.text = rightScore.score
                timer.performWithDelay(500, resetBall)
           end
	end
	leftLimit:addEventListener("collision", leftLimit)
	
	local rightLimit = display.newRect(display.contentWidth -5, 0, 5, display.contentHeight)
	rightLimit.isVisible = false
	rightLimit.collision = function(object, event)
            if event.phase == "ended" then
		leftScore.score = leftScore.score +1
        	leftScore.text = leftScore.score
                timer.performWithDelay(500, resetBall)
           end
	end
	rightLimit:addEventListener("collision", rightLimit)
	
	physics.addBody(leftLimit)
	physics.addBody(rightLimit)

	-- You have to specify "isSensor" after you added the body...
	leftLimit.isSensor = true
	leftLimit.bodyType = "static"
	rightLimit.isSensor = true
	rightLimit.bodyType = "static"
end

local function createGame()
	-- Setup game backdrop and scoreboard.
	local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	background:setFillColor(0)
	
	local midLine = display.newRect(halfW -5, 0, 10, display.contentHeight)
	midLine:setFillColor(70)
	
	leftScore = display.newText("0", 10, 20, native.systemFont, 50)
	leftScore.score = 0
	leftScore:setTextColor(100)
	rightScore = display.newText("0", halfW +10, 20, native.systemFont, 50)
	rightScore.score = 0
	rightScore:setTextColor(100)
	
	-- Initialize physics engine.
	initializePhysics()
        
        -- Setup the ball.
	localBall = ball.newBall(100, 100)
        
        -- Setup player pads.
	local playerWidth = display.contentWidth / 40;
	local playerHeight = display.contentHeight / 5;
	local player1 = player.newPlayer(playerWidth, halfH - playerHeight / 2, playerWidth, playerHeight)
	touchController.newTouchController(player1)
	local player2 = player.newPlayer(display.contentWidth - playerWidth - playerWidth, halfH - playerHeight / 2, playerWidth, playerHeight)
	trackingController.newTrackingController(player2, localBall)
        
	physics.addBody(player1, player1.physicsAttributes)
	physics.addBody(player2, player2.physicsAttributes)
	player1.bodyType = "static"
	player2.bodyType = "static"
	
	physics.addBody(localBall, localBall.physicsAttributes)
	
	localBall:applyLinearImpulse(1.5, 0.5, localBall.x, localBall.y)	
end

display.setStatusBar(display.HiddenStatusBar)
createGame()
