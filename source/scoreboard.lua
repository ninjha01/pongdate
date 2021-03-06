import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "observers"

local gfx <const> = playdate.graphics

SCOREBOARD = {
   score = 0,
   score_text = "*SCORE:* 0",
   won = false,
   lost = false,
}
function SCOREBOARD.handlePlayerCollision ()
   SCOREBOARD.score = SCOREBOARD.score + 1
   SCOREBOARD.score_text = "*SCORE:* " .. SCOREBOARD.score
end

function SCOREBOARD.setup ()
   table.insert(COLLISIONS.subscribers[COLLISIONS.enums.BALL_PLAYER], 1, SCOREBOARD.handlePlayerCollision)
end

function SCOREBOARD.update ()
   gfx.drawTextAligned(SCOREBOARD.score_text, 200, 120, kTextAlignment.center)
   
end
