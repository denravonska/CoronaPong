module(..., package.seeall)

local controlledEntity = nil
local offsetY = 0

-- Touch handler.
-- This handler is attached to the world but we only want to affect the paddle
-- if the user presses close to it. If the user touches within 1 paddle width to
-- the left or right of the paddle location we start controlling it until
-- release.
local function onTouchEvent(event)
   if event.phase == "began" then
      -- Start dragging if we are close to the entity
      local bounds = controlledEntity.contentBounds
      if event.y >= bounds.yMin and event.y <= bounds.yMax then
         local threshold = controlledEntity.width
         if event.x >= bounds.xMin - threshold and event.x < bounds.xMax + threshold then
            controlledEntity.isFocus = true
            offsetY = event.y - controlledEntity.y
         end
      end
   elseif event.phase == "moved" and controlledEntity.isFocus == true then
      local y = event.y - offsetY

      -- Limit the pad location so we don't go outside of the screen.
      if y < 1 then
         y = 1
      elseif y + controlledEntity.height > display.contentHeight then
         y = display.contentHeight - controlledEntity.height - 1
      end
         
      controlledEntity.y = y
      
   elseif event.phase == "ended" or event.phase == "cancelled" then
      controlledEntity.isFocus = false
   end
end

function newTouchController(entity)
   controlledEntity = entity
   Runtime:addEventListener("touch", onTouchEvent)
end