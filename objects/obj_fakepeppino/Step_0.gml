switch state
{
	case states.idle: scr_fakepeppino_idle (); break;
	case states.walk: scr_fakepeppino_walk (); break;
	case states.hit: scr_fakepeppino_hit (); break;
	case states.jump: scr_fakepeppino_jump (); break;
}
if place_meeting(x + hsp, y, obj_destructibles) 
{
	with instance_place(x + hsp, y, obj_destructibles)
		instance_destroy();
}

//Appear
if global.panic
	appeartimer--
if appeartimer <= 0
{
	x = start_x
	y = start_y
}

//Grab
var player = instance_nearest(x, y, obj_player)
if (player.x > x - 200 && player.x < x + 200) && sprite_index = spr_fakepeppino_walk && y == player.y
{
	scr_soundeffect(sfx_suplexdash)
	state = states.hit
	sprite_index = spr_fakepeppino_grabdash
	image_index = 0
	movespeed = 8
}

scr_collide()

