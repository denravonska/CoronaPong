module(..., package.seeall)

function newPlayer(x, y, w, h)
	local entity = display.newRect(x, y, w, h)
	entity:setReferencePoint(display.centerReferencePoint)
	entity:setFillColor(255)
	
	entity.physicsAttributes = { density = 1.0, friction = 0.3, bounce = 0.2 }
	
	return entity
end
