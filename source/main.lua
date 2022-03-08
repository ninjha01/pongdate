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
      for i=1, ticks do
	 BALL.undo()
      end
      playdate.wait(0.5)
   else
      PLAYER.update()
      BALL.update()
      ENEMY.update()
   end

   gfx.sprite.update()
   SCOREBOARD.update()
   playdate.timer.updateTimers()
end
   
