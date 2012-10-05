local physics = require("physics")
local player = require("scripts.Player")
local ball = require("scripts.Ball")
local touchController = require("scripts.TouchController")
local halfH = display.contentHeight / 2

local function initializePhysics()
	physics.start()
	physics.setDrawMode("hybrid")
	physics.setGravity(0, 0)
	
	local top = display.newRect(0, 5, display.contentWidth +1, 4)
	--top:setFillColor(0, 255, 0)
	--top:setStrokeColor(0, 255, 0)
	local bottom = display.newRect(0, display.contentHeight -5, display.contentWidth +1, 4)

	-- you have to specify "static" after you added the body...
	physics.addBody(top)
	top.bodyType = "static"

	physics.addBody(bottom)
	bottom.bodyType = "static"
end

local function createGame()
	initializePhysics()

	local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	background:setFillColor(0)

	-- Setup player pads. Controllers will be attached later.
	local playerWidth = display.contentWidth / 40;
	local playerHeight = display.contentHeight / 5;
	local player1 = player.newPlayer(10, halfH - playerHeight / 2, playerWidth, playerHeight)
	touchController.newTouchController(player1)
	local player2 = player.newPlayer(display.contentWidth - playerWidth - 10, halfH - playerHeight / 2, playerWidth, playerHeight)
	
	local ball = ball.newBall(100, 100)
	
	physics.addBody(player1, player1.physicsAttributes)
	player1.bodyType = "static"
	
	physics.addBody(player2, player2.physicsAttributes)
	player2.bodyType = "static"
	
	physics.addBody(ball, player2.physicsAttributes)
	
	ball:applyLinearImpulse(0.5, 1, ball.x, ball.y)
end

display.setStatusBar(display.HiddenStatusBar)
createGame()
