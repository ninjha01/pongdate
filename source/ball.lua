import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "enemy"
import "scoreboard"
import "utils"

local gfx <const> = playdate.graphics

-------------------------------------
-- Ball
-------------------------------------
BALL = {
   sprite = nil,
   xVelocity = 3,
   yVelocity = 3,
   MAX_VELOCITY = 10,
   history = {}   
}
function BALL.setup()
   local ballImage = gfx.image.new("images/ballImage")
   assert( ballImage )

   BALL.sprite = gfx.sprite.new( ballImage )
   BALL.sprite:moveTo( 200, 120 )
   BALL.sprite:add()
   BALL.sprite:setCollideRect( 0, 0, BALL.sprite:getSize() )
end

function BALL.undo()
   table.remove(BALL.history, 1) -- remove current state
   local lastState = table.remove(BALL.history, 1)
   if (lastState == nil) then
      print("WAITING")
      playdate.wait(0.1)
   else
      BALL.xVelocity = lastState.xVelocity
      BALL.yVelocity = lastState.yVelocity
      BALL.sprite:moveTo(lastState.xPos, lastState.yPos)
   end
end


function BALL.pushToHistory(xVelocity, yVelocity, xPos, yPos)
   table.insert(BALL.history, 1, { xVelocity = xVelocity, yVelocity = yVelocity, xPos = xPos, yPos = yPos})
end

function BALL.moveBy(x, y)
   local currX, currY = BALL.sprite:getPosition()
   xVelocity, yVelocity = BALL.xVelocity, BALL.yVelocity
   BALL.pushToHistory(xVelocity, yVelocity, currX, currY)

   BALL.sprite:moveBy(x, y)
   if currX >= MAX_X then
      currX = MAX_X - 1
      BALL.xVelocity = -1 * xVelocity
      BALL.sprite:moveTo( currX, currY )
   end
   if currX <= MIN_X then
      currX = MIN_X + 1
      BALL.xVelocity = -1 * xVelocity
      BALL.sprite:moveTo( currX, currY )
   end   
   if currY >= MAX_Y then
      currY = MAX_Y - 1      
      BALL.yVelocity = -1 * yVelocity
      BALL.sprite:moveTo( currX, currY )
   end
   if currY <= MIN_Y then
      currY = MIN_Y + 1 
      BALL.yVelocity = -1 * yVelocity
      BALL.sprite:moveTo( currX, currY )
   end
   assert(currX >= MIN_X and currX <= MAX_X)
   assert(currY >= MIN_Y and currY <= MAX_Y)
end

function BALL.increaseBallVelocity()
   local xSign = BALL.xVelocity > 1 and 1 or -1
   local ySign = BALL.yVelocity > 1 and 1 or -1
   local newXVelocity = xSign * (math.abs(BALL.xVelocity) + 1)
   local newYVelocity = ySign * (math.abs((BALL.yVelocity) + 1))
   if math.abs(newXVelocity) > BALL.MAX_VELOCITY then
      newXVelocity = BALL.MAX_VELOCITY
   end
   if math.abs(newYVelocity) > BALL.MAX_VELOCITY then
      newYVelocity = BALL.MAX_VELOCITY
   end
   BALL.xVelocity, BALL.yVelocity = newXVelocity, newYVelocity
end

function BALL.update()
   local currX, currY = BALL.sprite:getPosition()
   if BALL.isCollidingWith(PLAYER.sprite) then
      print("PLAYER COLLISION")
      BALL.xVelocity, BALL.yVelocity = BALL.xVelocity * -1 , BALL.yVelocity      
      BALL.increaseBallVelocity()
      BALL.moveBy( BALL.xVelocity, BALL.yVelocity)
      SCOREBOARD.score = SCOREBOARD.score + 1
   elseif BALL.isCollidingWith(ENEMY.sprite) then
      print("ENEMY COLLISION")
      BALL.xVelocity, BALL.yVelocity = BALL.xVelocity * -1 , BALL.yVelocity
      BALL.moveBy( BALL.xVelocity, BALL.yVelocity)
   else
      if not (playdate.getCrankTicks(1000) > 1) then
	 BALL.moveBy( BALL.xVelocity, BALL.yVelocity) -- move ball if player isn't undoing
      end
   end
end

function BALL.isCollidingWith(sprite)
   local collisions = BALL.sprite:overlappingSprites()
   for i = 1, #collisions do
      local colSprite = collisions[i]
      if (colSprite == sprite) then
	 return true
      end
   end
   return false
end
