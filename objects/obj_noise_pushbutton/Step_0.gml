if sprite_index == spr_noise_button && floor(image_index) >= image_number - 1
{
	hspeed = 2.8
	image_xscale = 1
	sprite_index = spr_noise_walk
}

if floor(image_index) == 87
{
	// setup pizzatime
	instance_create(x, y, obj_itspizzatime)
	global.panic = true
	
	global.minutes = 2
	global.seconds = 59
	if global.modifier == mods.no_toppings
	{
		global.minutes = 3
		global.seconds = 29
	}
	
	if global.panicbg
		scr_panicbg_init()
		
	global.wave = 0;
	global.maxwave = (global.minutes * 60 + global.seconds) * 60;
	
	with obj_camera
		alarm[1] = 60;
	
	// scare player
	with obj_player
	{
		state = states.backbreaker;
		sprite_index = spr_bossintro;
		image_index = 0;
		image_speed = 0.35;
	}
}
scr_collide()

