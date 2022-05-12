var nearest = instance_nearest(x, y, obj_player);
if nearest.x < x + 100 && nearest.x >= x - 100 && nearest.y > y
{
	if !activated
	{
		grav = 0.5
		activated = true
		image_speed = 0.35
	}
}

var player = instance_place(x, y, obj_player1);
if player && activated && !hitwall && player.state != states.stunned
{
	with player
	{
		if scr_transformationcheck() && grounded
		{
			if place_meeting(x, y + 1, obj_platform) && !scr_solidwall(x, y + 1)
				y += 1
			
			state = states.stunned
			sprite_index = spr_squished
			image_index = 0
		}
	}
}

if activated && vsp > 0 && scr_solid(x, y + 1)
	hsp = image_xscale * 8

var des = instance_place(x + hsp, y, obj_destructibles);
if des
{
	with des
		instance_destroy()
}

if !des && scr_solidwall(x + hsp, y) && activated && !place_meeting(x + hsp, y, obj_slope) && !hitwall && scr_solid(x, y + 1)
{
	with instance_create(x, y, obj_sausageman_dead)
		sprite_index = spr_noiseboulder
	instance_destroy()
}

if !hitwall
	scr_collide()

