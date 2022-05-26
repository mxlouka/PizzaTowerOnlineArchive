if visited
	sprite_index = spr_doorvisited

var player = instance_place(x, y, obj_player);
if player && player.state == states.comingoutdoor
	visited = true

