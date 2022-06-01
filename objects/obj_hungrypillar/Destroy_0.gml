// activate escape enemies and collects
if global.gameplay != 0
{
	instance_activate_object(obj_baddie);
	with obj_baddie
	{
		if escape
		{
			visible = true;
			instance_create(x, y, obj_genericpoofeffect);
		}
	}
		
	instance_activate_object(obj_collectescape);
	with obj_collectescape
	{
		visible = true;
		instance_create(x, y, obj_genericpoofeffect);
	}
}

instance_create(x, y, obj_bangeffect)
repeat 3
{
	create_particle(x, y, particles.baddiegibs);
	instance_create(x, y, obj_slapstar)
}
	
with obj_camera
{
	alarm[1] = 60;
		
	shake_mag = 3;
	shake_mag_acc = 3 / room_speed;
}

with instance_create(x, y, obj_sausageman_dead)
{
	sprite_index = other.spr_dead;
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
		
	if check_sugary()
		sugary = true;
}
scr_soundeffect(sfx_killenemy)

if !instance_exists(obj_endlevelfade)
{
	instance_create(x, y, obj_itspizzatime)
	
	scr_panictime();
	global.panic = true
	
	if global.snickrematch
		instance_create(room_width / 2, -50, obj_snickexi);
		
	// Start up panicbg effects if option is enabled
	if global.panicbg
		scr_panicbg_init()
		
	global.wave = 0;
	global.maxwave = (global.minutes * 60 + global.seconds) * 60;
}
//ds_list_add(global.saveroom, id)
	
with obj_panicdebris
{
	canflash = true;
	event_user(0);
}

