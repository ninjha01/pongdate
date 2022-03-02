import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "ball"
import "player"
import "enemy"

local gfx <const> = playdate.graphics

function myGameSetUp()
   PLAYER.setup()
   ENEMY.setup()
   BALL.setup()
end

myGameSetUp()

function playdate.update()
   PLAYER.update()
   BALL.update()
   ENEMY.update()

   gfx.sprite.update()
   playdate.timer.updateTimers()
end
