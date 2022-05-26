event_inherited();
enter = false;
index = 0;

upbox = function(pbox)
{
	scr_soundeffect(sfx_box)
	pbox.depth = -10
	box = true
	mach2 = 0
	
	with obj_camera
		chargecamera = 0
	
	doorx = pbox.x
	x = doorx;
	y = pbox.y + 24
			
	sprite_index = spr_uppizzabox
	image_index = 0
	state = states.door
			
	pbox.enter = true;
}
downbox = function(pbox)
{
	pbox.depth = -10
	scr_soundeffect(sfx_box)
	box = true
	mach2 = 0
	
	with obj_camera
		chargecamera = 0
	
	doorx = other.x
	if !scr_stylecheck(2)
		x = doorx;
	
	sprite_index = spr_downpizzabox
	image_index = 0
	state = states.door
		
	pbox.enter = true;
}

