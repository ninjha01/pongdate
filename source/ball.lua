import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "enemy"
import "scoreboard"

local gfx <const> = playdate.graphics
-------------------------------------
-- Ball
-------------------------------------
BALL = {
   sprite = nil,
   xVelocity = 3,
   yVelocity = 1,
   MAX_VELOCITY = 12
}
function BALL.setup()
   local ballImage = gfx.image.new("images/ballImage")
   assert( ballImage )

   BALL.sprite = gfx.sprite.new( ballImage )
   BALL.sprite:moveTo( 200, 120 )
   BALL.sprite:add()
   BALL.sprite:setCollideRect( 0, 0, BALL.sprite:getSize() )
end

function BALL.moveBy(x, y)
   local currX, currY = BALL.sprite:getPosition()
      
   xVelocity, yVelocity = BALL.xVelocity, BALL.yVelocity
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

function BALL.update()
   if BALL.isCollidingWith(PLAYER.sprite) then
      print("PLAYER COLLISION")
      local xSign = BALL.xVelocity > 1 and 1 or -1
      -- local newXVelocity = -1 * xSign * (BALL.xVelocity < BALL.MAX_VELOCITY) and Ball.xVelocity or BALL.MAX_VELOCITY
      local newXVelocity = -1 * xSign * (BALL.xVelocity + 1)
      BALL.xVelocity, BALL.yVelocity = newXVelocity, BALL.yVelocity
      BALL.moveBy( BALL.xVelocity, BALL.yVelocity)
      SCOREBOARD.score = SCOREBOARD.score + 1
   elseif BALL.isCollidingWith(ENEMY.sprite) then
      print("ENEMY COLLISION")
      BALL.xVelocity, BALL.yVelocity = BALL.xVelocity * -1 , BALL.yVelocity
      BALL.moveBy( BALL.xVelocity, BALL.yVelocity)
   else
      BALL.moveBy( BALL.xVelocity, BALL.yVelocity)
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
