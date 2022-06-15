if sprite_index == spr_pizzaportalend && !instance_exists(obj_fadeout)
{
	with obj_player
	{
		visible = true
		sprite_index = spr_pizzaportalentrancestart
		image_index = 0
		targetRoom = other.targetRoom
		targetDoor = other.targetDoor
		instance_create(0, 0, obj_fadeout)
		
		ds_list_clear(global.baddieroom)
		ds_list_clear(global.escaperoom)
	}
}
