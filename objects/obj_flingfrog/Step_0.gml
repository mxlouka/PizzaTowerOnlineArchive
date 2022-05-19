if playerid == noone
{
	var player = instance_nearest(x, y, obj_player);
	if instance_exists(player)
	{
		var lookplayer = point_direction(x, y, player.x, player.y);
		handsx = x + lengthdir_x(80, lookplayer);
		handsy = y + max(lengthdir_y(80, lookplayer), y);
	}
	sprite_index = spr_flingfrog;
}
if playerid != noone
{
	if !instance_exists(playerid) or playerid.state != states.fling
	{
		playerid = noone;
		exit;
	}
	handsx = playerid.x;
	handsy = playerid.y;
	sprite_index = spr_flingfrogmad;
}

