function scr_player_finishingblow()
{
	hsp = 0
	vsp = 0

	if floor(image_index) >= image_number - 1
		state = states.normal
	
	if floor(image_index) == 4 && global.gameplay != 0
		image_index += 2;
	
	if floor(image_index) >= 6 - (global.gameplay != 0) && !instance_exists(obj_swordhitbox)
	{
		if instance_exists(baddiegrabbedID) && baddiegrabbedID.object_index == obj_junk && scr_checkskin(checkskin.p_anton)
			scr_soundeffect(sfx_punchball_throw);
		
		scr_soundeffect(sfx_punch)
		scr_soundeffect(sfx_killingblow)
		gp_vibration(0.8, 0.8, 0.65);
	
		with instance_create(x, y, obj_swordhitbox)
			playerid = other.object_index
	}
	
	if floor(image_index) == 0 && !instance_exists(obj_swordhitbox) && sprite_index == spr_swingdingend
	{
		if instance_exists(baddiegrabbedID) && baddiegrabbedID.object_index == obj_junk && scr_checkskin(checkskin.p_anton)
			scr_soundeffect(sfx_punchball_throw);
	
		scr_soundeffect(sfx_killingblow)
		gp_vibration(0.8, 0.8, 0.65);
	
		with instance_create(x, y, obj_swordhitbox)
			playerid = other.object_index
	}
	
	image_speed = 0.4;
	if global.gameplay == 0
		image_speed = 0.35;
	landAnim = false
}

