module(..., package.seeall)

local controlledEntity = nil
local localBall = nil

local function onUpdateAI(event)
    local ydiff = (localBall.y - (controlledEntity.height / 2)) - controlledEntity.y
    controlledEntity:translate(0, ydiff)
end

function newTrackingController(entity, ball)
   controlledEntity = entity
   localBall = ball
   
   timer.performWithDelay(100, onUpdateAI, 0)
end
