import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "constants"

local gfx <const> = playdate.graphics


-------------------------------------
-- Player
-------------------------------------

PLAYER = {
   sprite = nil,
   velocity = 5,
}
function PLAYER.setup()
   local playerImage = gfx.image.new("images/playerImage")
   assert( playerImage )

   PLAYER.sprite = gfx.sprite.new( playerImage )
   PLAYER.sprite:moveTo( MAX_X - 20, (MIN_Y + MAX_Y) / 2 )
   PLAYER.sprite:add()
   PLAYER.sprite:setCollideRect( 0, 0, PLAYER.sprite:getSize() )
end
function PLAYER.moveBy(x, y)
   PLAYER.sprite:moveBy(x, y)
end
function PLAYER.update()
   local currX, currY = PLAYER.sprite:getPosition()
   local width, height = PLAYER.sprite:getSize()
   local spriteTop, spriteBottom = currY - (height / 2), currY + (height / 2)
   
   local function canGoUp()
      return spriteTop >= MIN_Y + 5
   end
   local function canGoDown()
      return spriteBottom <= MAX_Y - 5
   end

   if playdate.buttonIsPressed( playdate.kButtonUp ) then
      if canGoUp() then
	 PLAYER.moveBy( 0, -1 * PLAYER.velocity )
      end
   end
   if playdate.buttonIsPressed( playdate.kButtonDown ) then
      if canGoDown() then
	 print("Moving down")
	 PLAYER.moveBy( 0, PLAYER.velocity )
      end
   end
end

