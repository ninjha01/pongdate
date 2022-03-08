import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "constants"
import "utils"

local gfx <const> = playdate.graphics


-------------------------------------
-- Player
-------------------------------------

PLAYER = {
   sprite = nil,
   velocity = 5,
   command_queue = {},
   executed_queue = {}
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
   smoothMove(PLAYER.sprite, x, y)
end

function PLAYER.moveUp()
   local _, height = PLAYER.sprite:getSize()
   local _, currY = PLAYER.sprite:getPosition()   
   local spriteTop = currY - (height / 2)
   local function canGoUp()
      return spriteTop >= MIN_Y + 5
   end
   if canGoUp() then
      PLAYER.moveBy( 0, -1 * PLAYER.velocity )
   end
end

function PLAYER.undoMoveUp()
   PLAYER.moveBy( 0, 1 * PLAYER.velocity )
end

function PLAYER.moveDown()
   local _, height = PLAYER.sprite:getSize()
   local _, currY = PLAYER.sprite:getPosition()   
   local spriteBottom = currY + (height / 2)
   local function canGoDown()
      return spriteBottom <= MAX_Y - 5
   end
   if canGoDown() then
      PLAYER.moveBy( 0, 1 * PLAYER.velocity )
   end
end


function PLAYER.undoMoveDown()
   PLAYER.moveBy( 0, -1 * PLAYER.velocity )
end


function PLAYER.update()
   local nextCommand = table.remove(PLAYER.command_queue, #PLAYER.command_queue) -- get next command
   if not (nextCommand == nil) then
      nextCommand.execute(PLAYER)
      table.insert(PLAYER.executed_queue, 1, nextCommand)
   end
end

function PLAYER.undo()
   local nextCommand = table.remove(PLAYER.executed_queue, 1) -- get next exectued
   if not (nextCommand == nil) then
      nextCommand.undo(PLAYER)
   end
end
