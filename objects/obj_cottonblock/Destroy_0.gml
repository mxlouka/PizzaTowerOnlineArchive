with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_sausageman_dead)
{
    if other.sprite_index == spr_chocofrogbig
		sprite_index = spr_chocofrogbig_dead;
	else
		sprite_index = spr_chocofrogsmall_dead;
	
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	sugary = true;
}
instance_create(x, y, obj_genericpoofeffect);
ds_list_add(global.saveroom, id);
