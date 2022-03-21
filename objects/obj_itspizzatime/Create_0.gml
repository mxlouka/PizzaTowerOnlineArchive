up = 540 + 100;
image_speed = 0.35;

spr = spr_itspizzatime;
if instance_exists(obj_player)
{
	if obj_player.character == "SP" or obj_player.character == "SN"
		spr = spr_glucosegetaway;
	if obj_player.character == "PP"
		spr = spr_itspizzatime_PP;
}
