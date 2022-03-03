import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "ball"

local gfx <const> = playdate.graphics

-------------------------------------
-- Enemy
-------------------------------------

ENEMY = {
   sprite = nil,
   velocity = 2,
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
   ENEMY.sprite:moveBy(x, y)
end

function ENEMY.update()
   local ballX, ballY = BALL.sprite:getPosition()
   local enemryX, enemyY = ENEMY.sprite:getPosition()
   if enemyY > ballY then
      ENEMY.moveBy( 0, -1 * ENEMY.velocity )
   elseif enemyY < ballY then
      ENEMY.moveBy( 0, ENEMY.velocity )
   end
end
