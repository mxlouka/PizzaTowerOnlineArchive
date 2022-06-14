x = room_width / 2
y = -100
if global.gameplay != 0
{
	x = obj_player.x
	y = obj_player.y
}

if sugary
	reset_pos();

if room == rank_room
	instance_destroy(id, false)

