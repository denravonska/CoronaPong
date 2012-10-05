local player = require("scripts.Player")
local halfH = display.contentHeight / 2

local function createGame()
	local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	background:setFillColor(0)

	-- Setup player pads. Controllers will be attached later.
	local playerWidth = display.contentWidth / 40;
	local playerHeight = display.contentHeight / 5;
	local player1 = player.newPlayer(10, halfH - playerHeight / 2, playerWidth, playerHeight)
	local player2 = player.newPlayer(display.contentWidth - playerWidth - 10, halfH - playerHeight / 2, playerWidth, playerHeight)
end

display.setStatusBar(display.HiddenStatusBar)
createGame()
