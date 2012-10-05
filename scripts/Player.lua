module(..., package.seeall)

function newPlayer(x, y, w, h)
   local entity = display.newRect(x, y, w, h)
   --entity:setReferencePoint(display.centerReferencePoint)
   entity:setFillColor(255)
   
   return entity
end
