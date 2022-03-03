import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

SCOREBOARD = {
   score = 0
}

function SCOREBOARD.setup ()
end

function SCOREBOARD.update ()
   gfx.drawTextAligned("*SCORE:* " .. SCOREBOARD.score, 200, 120, kTextAlignment.center)
end
