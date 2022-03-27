if room == rm_editor exit;
/*
if global.key_inv == true
{
vsp = -15
hsp = random_range(-4, 4)
}
*/

hsp = 0
vsp = 0

inv_frame = false

grav = 0.4
image_speed = 0.35

depth = 1
if place_meeting(x, y, obj_destructibles) or place_meeting(x, y, obj_metalblock)
	depth += 100;

if global.key_inv
	instance_destroy();
if check_sugary()
	sprite_index = spr_key_ss;
