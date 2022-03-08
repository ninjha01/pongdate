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

ENEMY = {
   sprite = nil,
   velocity = 5,
   command_queue = {},
   executed_queue = {}
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

function ENEMY.moveUp()
   local _, height = ENEMY.sprite:getSize()
   local _, currY = ENEMY.sprite:getPosition()   
   local spriteTop = currY - (height / 2)
   local function canGoUp()
      return spriteTop >= MIN_Y + 5
   end
   if canGoUp() then
      ENEMY.moveBy( 0, -1 * ENEMY.velocity )
   end
end

function ENEMY.undoMoveUp()
   ENEMY.moveBy( 0, 1 * ENEMY.velocity )
end


function ENEMY.moveDown()
   local _, height = ENEMY.sprite:getSize()
   local _, currY = ENEMY.sprite:getPosition()   
   local spriteBottom = currY + (height / 2)
   local function canGoDown()
      return spriteBottom <= MAX_Y - 5
   end
   if canGoDown() then
      ENEMY.moveBy( 0, 1 * ENEMY.velocity )
   end
end


function ENEMY.undoMoveDown()
   ENEMY.moveBy( 0, -1 * ENEMY.velocity )
end

function ENEMY.undo()
   local nextCommand = table.remove(ENEMY.executed_queue, 1) -- get next exectued
   if not (nextCommand == nil) then
      nextCommand.undo(ENEMY)
   end
end



function ENEMY.ai()
   local function getBounds()
      local enemyX, enemyY = ENEMY.sprite:getPosition()
      local enemyWidth, enemyHeight = ENEMY.sprite:getSize()
      local enemyTop, enemyBottom = enemyY - (enemyHeight / 2), enemyY + (enemyHeight / 2)
      return enemyTop, enemyBottom
   end   

   local function isBallWithin()
      local ballX, ballY = BALL.sprite:getPosition()
      local enemyTop, enemyBottom = getBounds()
      return ballY >= enemyTop and ballY <= enemyBottom
   end
   local enemyX, enemyY = ENEMY.sprite:getPosition()
   local ballX, ballY = BALL.sprite:getPosition()

   -- Don't move if ball is behind enemy
   if enemyX > ballX then
      return
   end

   if not isBallWithin() then 
      if enemyY > ballY then
	 table.insert(ENEMY.command_queue, 1, MOVE_UP)
      elseif enemyY < ballY then
	 table.insert(ENEMY.command_queue, 1, MOVE_DOWN)
      end
   end
end

function ENEMY.update()
   local nextCommand = table.remove(ENEMY.command_queue, #ENEMY.command_queue) -- get next command
   if not (nextCommand == nil) then
      nextCommand.execute(ENEMY)
      table.insert(ENEMY.executed_queue, 1, nextCommand)
   end
end
