scr_collide();
if content == noone or !is_real(content) && !object_exists(content)
	exit;

with obj_player
{
	if character == "V" && (other.content == obj_shotgun or other.content == obj_woodbarrel)
		instance_destroy(other.id);
	if character == "S" && other.content == obj_shotgun
		instance_destroy(other.id);
}

if (!instance_exists(baddieid) && content != obj_shotgun) or (!instance_exists(baddieid) && content == obj_shotgun && !obj_player1.shotgunAnim)
	refresh--;

if refresh <= 0 
{
	image_speed = 0.35
	if floor(image_index) == 5
	{
		with instance_create(x + (content == obj_shotgun ? -44 : 0), y - 20, content)
		{
			image_xscale = (object_index == obj_shotgun ? 1 : other.image_xscale);
			state = states.stun;
			stunned = 50;
			vsp = -5;
			other.baddieid = id;
			important = true;
		}
		
		refresh = 100;
	}
}