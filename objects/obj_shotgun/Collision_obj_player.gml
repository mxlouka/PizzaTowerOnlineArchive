if other.character != "S" && other.character != "V"
{
	if !other.shotgunAnim && !other.backupweapon && other.state == states.handstandjump
	{
		with other
		{
			shotgunAnim = true
			state = states.shotgun
			image_index = 0
			sprite_index = spr_shotgunpullout
		}
		
		global.gotshotgun = true
		scr_soundeffect(sfx_shotgungot)
		instance_destroy()
		
		tv_push_prompt_once(tv_create_prompt("This is the shotgun powerup text", 2, spr_tv_shotgun, 3), "shotgun");
		global.heattime = 60;
		
		with obj_tv
		{
			image_speed = 0.25
			message = choose("ITS TIME TO KICK ASS", "ITS TIME TO ASS", "ITS TIME TO CHEW ASS")
			alarm[0] = 200
			showtext = true
			tvsprite = spr_tvdook
		}
	}
}

