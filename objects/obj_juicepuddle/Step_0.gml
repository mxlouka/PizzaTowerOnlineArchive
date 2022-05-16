scr_collide();

if !grounded
	sprite_index = spr_juicepuddleair;
else
{
	if sprite_index == spr_juicepuddleair
	{
		image_index = 0;
		sprite_index = spr_juicepuddlesplash;
	}
	if sprite_index == spr_juicepuddlesplash && image_index >= image_number - 1
		sprite_index = spr_juicepuddledone;
	
	var slope = instance_place(x, y + 1, obj_slope);
	if slope
		img_angle = 45 / slope.image_xscale;
	
	var player = instance_place(x, y, obj_player);
	if player
	{
		with player
		{
			if scr_transformationcheck()
			{
				if global.gameplay == 0
				{
					if state != states.slipnslide
					{
						sprite_index = spr_slipnslide
						state = states.slipnslide
						if movespeed < 12
							movespeed = 12
					}
				}
				else
				{
					scr_soundeffect(sfx_tumble2)
					sprite_index = spr_slipbanan1;
				    vsp = -11;
				    image_index = 0;
				    state = states.slipbanan;
				}
				instance_destroy(other);
			}
		}
	}
}

