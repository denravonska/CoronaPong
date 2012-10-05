
local physics = require("physics")
local player = require("scripts.Player")
local ball = require("scripts.Ball")
local touchController = require("scripts.TouchController")

local halfH = display.contentHeight / 2
local halfW = display.contentWidth / 2

local function initializePhysics()
	physics.start()
	--physics.setDrawMode("hybrid")
	physics.setGravity(0, 0)
	
	local top = display.newRect(0, 0, display.contentWidth +1, 4)
	local bottom = display.newRect(0, display.contentHeight -4, display.contentWidth +1, 4)

	local attributes = { friction = 0, bounce = 1.0 }
	
	physics.addBody(top, attributes)
	physics.addBody(bottom, attributes)

	-- you have to specify "static" after you added the body...
	top.bodyType = "static"
	bottom.bodyType = "static"
end

local function createGame()
	-- Setup game backdrop and scoreboard.
	local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	background:setFillColor(0)
	
	local midLine = display.newRect(halfW -5, 0, 10, display.contentHeight)
	midLine:setFillColor(70)
	
	local player1Score = display.newText("Score: 0", 10, 20, native.systemFontBold, 50)
	player1Score:setTextColor(100)
	local player2Score = display.newText("Score: 1", halfW +10, 20, native.systemFont, 50)
	player2Score:setTextColor(100)
	
	-- Initialize physics engine.
	initializePhysics()

	-- Setup player pads.
	local playerWidth = display.contentWidth / 40;
	local playerHeight = display.contentHeight / 5;
	local player1 = player.newPlayer(playerWidth, halfH - playerHeight / 2, playerWidth, playerHeight)
	touchController.newTouchController(player1)
	local player2 = player.newPlayer(display.contentWidth - playerWidth - playerWidth, halfH - playerHeight / 2, playerWidth, playerHeight)
	
	local ball = ball.newBall(100, 100)
	
	physics.addBody(player1, player1.physicsAttributes)
	physics.addBody(player2, player2.physicsAttributes)
	player1.bodyType = "static"
	player2.bodyType = "static"
	
	physics.addBody(ball, player2.physicsAttributes)
	
	ball:applyLinearImpulse(0.5, 1, ball.x, ball.y)	
end

display.setStatusBar(display.HiddenStatusBar)
createGame()
