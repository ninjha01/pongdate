MOVE_UP = {}

function MOVE_UP.execute(actor)
   actor.moveUp()
end

function MOVE_UP.undo(actor)
   actor.undoMoveUp()
end

MOVE_DOWN = {}

function MOVE_DOWN.execute(actor)
   actor.moveDown()
end

function MOVE_DOWN.undo(actor)
   actor.undoMoveDown()
end
