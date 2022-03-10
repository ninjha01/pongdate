import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"

import "observers"
import "commands"
import "sounds"
import "start_menu"

import "ball"
import "player"
import "enemy"
import "scoreboard"


local gfx <const> = playdate.graphics

GAME_STATE = {
   current = nil
}
GAME_STATE.enums = {
   start = 1,
   playing = 2,
   won = 3,
   lost = 4,
   paused = 5,
}

local function initializeStart()
   SOUNDS.setup()
   START_MENU.setup()
   GAME_STATE.current = GAME_STATE.enums.start
end

local function initializePlaying()
   PLAYER.setup()
   ENEMY.setup()
   BALL.setup()
   SCOREBOARD.setup()
end

local function initializeWon()

end

local function initializeLost()

end

local function initializePaused()

end

local function updateStart()
   if playdate.buttonIsPressed( playdate.kButtonA ) then
      START_MENU.teardown()
      initializePlaying()
      GAME_STATE.current = GAME_STATE.enums.playing
   end
end


local function updatePlaying()
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
      SCOREBOARD.update()
   end

   if playdate.buttonIsPressed( playdate.kButtonUp ) then
      table.insert(PLAYER.command_queue, 1, MOVE_UP)
   end
   if playdate.buttonIsPressed( playdate.kButtonDown ) then
      table.insert(PLAYER.command_queue, 1, MOVE_DOWN)
   end
end



function playdate.update()
   gfx.sprite.update()
   playdate.timer.updateTimers()   
   if (GAME_STATE.current == GAME_STATE.enums.start) then
      updateStart()
   elseif (GAME_STATE.current == GAME_STATE.enums.playing) then
      updatePlaying()
   else
      print("UNKNOWN STATE " .. GAME_STATE.current)
   end

end

initializeStart()
