COLLISIONS = {}
COLLISIONS.enums = {
   BALL_PLAYER = 1,
   BALL_ENEMY = 2,
   BALL_PLAYER_EDGE = 3,
   BALL_ENEMY_EDGE = 4,
   BALL_NEUTRAL_EDGE = 5,
}

COLLISIONS.subscribers = {}
for enum_key, enum_value in pairs(COLLISIONS.enums) do
   COLLISIONS.subscribers[enum_value] = {}
end

function COLLISIONS.onCollision(collisionEnum)
   local subscribers = COLLISIONS.subscribers[collisionEnum]
   if (subscribers == nil) then
      error("Unexpected event")
   else
      for _, onNotify in pairs(subscribers) do
	 onNotify()
      end
   end
end
