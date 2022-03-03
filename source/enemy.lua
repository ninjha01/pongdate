import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "constants"
import "ball"
import "utils"

local gfx <const> = playdate.graphics

-------------------------------------
-- Enemy
-------------------------------------

ENEMY = {
   sprite = nil,
   speed = 5,
}

function ENEMY.setup()
   local playerImage = gfx.image.new("images/playerImage")
   assert( playerImage )

   ENEMY.sprite = gfx.sprite.new( playerImage )
   ENEMY.sprite:moveTo( MIN_X + 20, (MIN_Y + MAX_Y) / 2 )
   ENEMY.sprite:add()
   ENEMY.sprite:setCollideRect( 0, 0, ENEMY.sprite:getSize() )
end

function ENEMY.moveBy(x, y)
   smoothMove(ENEMY.sprite, x, y)
end

function ENEMY.getBounds()
   local enemyX, enemyY = ENEMY.sprite:getPosition()
   local enemyWidth, enemyHeight = ENEMY.sprite:getSize()
   local enemyTop, enemyBottom = enemyY - (enemyHeight / 2), enemyY + (enemyHeight / 2)
   return enemyTop, enemyBottom
end   

function ENEMY.isBallWithin()
   local ballX, ballY = BALL.sprite:getPosition()
   local enemyTop, enemyBottom = ENEMY.getBounds()
   return ballY >= enemyTop and ballY <= enemyBottom
end

function ENEMY.update()
   local enemyX, enemyY = ENEMY.sprite:getPosition()
   local ballX, ballY = BALL.sprite:getPosition()
   -- Don't move if ball is behind enemy
   if enemyX > ballX then
      return
   end

   local enemyWidth, enemyHeight = ENEMY.sprite:getSize()
   local enemyTop, enemyBottom = ENEMY.getBounds()
   
   local function canGoUp()
      return enemyTop >= MIN_Y + 5
   end
   local function canGoDown()
      return enemyBottom <= MAX_Y - 5
   end

   if not ENEMY.isBallWithin() then 
      if enemyY > ballY then
	 if canGoUp() then
	    ENEMY.moveBy( 0, -1 * ENEMY.speed )
	 end
      elseif enemyY < ballY then
	 if canGoDown() then
	    ENEMY.moveBy( 0, ENEMY.speed )
	 end
      end
   end
end
