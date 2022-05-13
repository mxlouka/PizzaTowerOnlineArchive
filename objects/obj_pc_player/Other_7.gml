if sprite_index == spr_jump
{
	sprite_index = spr_fall;
	image_index = 0;
}
if sprite_index == spr_crouchjump
{
	sprite_index = spr_crouchfall;
	image_index = 0;
}
if sprite_index == spr_playerN_doublejump
	sprite_index = spr_playerN_doublejumpfall;
if sprite_index == spr_playerV_revolvershoot
	state = pc_states.normal;

