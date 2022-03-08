import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"

import "ball"
import "player"
import "enemy"
import "scoreboard"
import "observers"
import "commands"


local gfx <const> = playdate.graphics

function myGameSetUp()
   PLAYER.setup()
   ENEMY.setup()
   BALL.setup()
   SCOREBOARD.setup()
end

myGameSetUp()

function playdate.update()
   local ticks = math.abs(playdate.getCrankTicks(40))
   if ticks > 1 then
      for _ = 1, ticks do
	 BALL.undo()
	 PLAYER.undo()
	 ENEMY.undo()
      end
      playdate.wait(0.5)
   else
      ENEMY.ai()
      PLAYER.update()
      BALL.update()
      ENEMY.update()
   end

   if playdate.buttonIsPressed( playdate.kButtonUp ) then
      table.insert(PLAYER.command_queue, 1, MOVE_UP)
   end
   if playdate.buttonIsPressed( playdate.kButtonDown ) then
      table.insert(PLAYER.command_queue, 1, MOVE_DOWN)
   end

   gfx.sprite.update()
   SCOREBOARD.update()
   playdate.timer.updateTimers()
end
   
