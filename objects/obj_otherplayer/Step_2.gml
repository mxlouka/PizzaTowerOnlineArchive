xscale = gms_other_get(player_id, "xscale")
yscale = gms_other_get(player_id, "yscale")

image_index = gms_other_get_real(player_id, "image_index");
img_angle = gms_other_get(player_id, "img_angle")

state = gms_other_get(player_id, "state")
spr_palette = gms_other_get(player_id, "spr_palette")
paletteselect = gms_other_get(player_id, "paletteselect")

if state == states.taxi
	visible = true;
else
	visible = gms_other_get_real(player_id, "visible");

if gms_other_get(player_id, "box")
{
	if instance_exists(obj_pizzabox)
		depth = obj_pizzabox.depth + 1;
	else
		depth = 150;
}
else if place_meeting(x, y, obj_secretblock)
or place_meeting(x, y, obj_secretbigblock)
or place_meeting(x, y, obj_secretmetalblock)
	image_alpha = 0.5;
else
	depth = -6;

/*
pvp = gms_other_get_real(player_id, "pvp");
if pvp
{
	hurted = gms_other_get_real(player_id, "pvp_hurted");
	cutscene = gms_other_get_real(player_id, "pvp_cutscene");
	if pvp_cooldown > 0
		pvp_cooldown--;
}
*/
pvp = false;

pause = gms_other_get_real(player_id, "pause");

