if index == -1 exit;

var player = instance_place(x, y, obj_player);
if player && (player.state = states.normal or player.state = states.mach1 or player.state == states.pogo or player.state = states.mach2 or player.state = states.mach3 or player.state = states.Sjumpprep)  && sprite_index = spr_doorkey && player.key_up && player.grounded && global.key_inv > 0
{
	player.doorx = x + 50
	player.state = states.victory
	player.image_index = 0
	
	image_index = 0
	sprite_index = spr_doorkeyopen
	image_speed = 0.35
	instance_create(x + 50, y + 50, obj_lock)
	global.key_inv -= 1
}

if sprite_index == spr_doorkeyopen && floor(image_index) >= 2
{
	opened = true;
	sprite_index = spr_doorvisited;
}

if player && floor(player.image_index) == player.image_number - 4 && player.state = states.victory
{
	var door_id = id;
	with player
	{
		index = other.index;
		if !instance_exists(obj_fadeout)
		{
			scr_soundeffect(sfx_door)
			with instance_create(x,y,obj_fadeout)
			{
				_id = door_id;
				index = other.index;
				custom_level = true;
			}
		}
	}
}

