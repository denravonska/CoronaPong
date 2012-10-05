module(..., package.seeall)

function newBall(x, y)
	local entity = display.newRect(x, y, 10, 10)
	entity:setReferencePoint(display.centerReferencePoint)
	entity:setFillColor(255, 0, 0)
	
	entity.physicsAttributes = { density = 1.0, friction = 0.0, bounce = 1.0 }
	
	return entity
end
