import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics


-------------------------------------
-- Enemy
-------------------------------------

ENEMY = {
   sprite = nil,
   velocity = 5,
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
   ENEMY.moveBy(0, 2)
end
