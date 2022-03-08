import "CoreLibs/object"

import "observers"

SOUNDS = {}
local sfx <const> = playdate.sound

function SOUNDS.bump()
   local sound = playdate.sound.synth.new(sfx.kWaveTriangle)
   print("playing note")
   sound:playNote(261.63, 0.5, 0.05)
end

function SOUNDS.setup()
   table.insert(COLLISIONS.subscribers[COLLISIONS.enums.BALL_PLAYER], 1, SOUNDS.bump)
   table.insert(COLLISIONS.subscribers[COLLISIONS.enums.BALL_ENEMY], 1, SOUNDS.bump)
end
