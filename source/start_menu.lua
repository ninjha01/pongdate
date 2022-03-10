local gfx <const> = playdate.graphics
import "CoreLibs/graphics"
START_MENU = {}

CENTER_X, CENTER_Y = 200, 120
function START_MENU.setup()
   gfx.drawTextAligned("*PONGDATE*", CENTER_X, CENTER_Y - 60, kTextAlignment.center)
   gfx.drawTextAligned("> START", CENTER_X, CENTER_Y, kTextAlignment.center)
   gfx.drawTextAligned("_By Nishant Jha_", CENTER_X, CENTER_Y + 60, kTextAlignment.center)
end


function START_MENU.teardown()
   gfx.clear()
end
