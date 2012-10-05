module(..., package.seeall)

function newPlayer(x, y, w, h)
	local entity = display.newRect(x, y, w, h)
	entity:setReferencePoint(display.TopLeftReferencePoint)
	entity:setFillColor(255)
	
	entity.physicsAttributes = { density = 1.0, friction = 0.0, bounce = 1.0 }
	
	return entity
end
