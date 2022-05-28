if live_call() return live_result;

// set all inputs to none
key_up = false
key_up2 = false
key_right = false
key_right2 = false
key_left = false
key_left2 = false
key_down = false
key_down2 = false
key_jump = false
key_jump2 = false
key_slap = false
key_slap2 = false
key_taunt = false
key_taunt2 =  false
key_attack = false
key_attack2 = false
key_shoot = false
key_shoot2 = false

// figure out what to do
var player = obj_player1;

var disx = player.x - x;
var disy = player.y - y;

if abs(disx) > 32 && (state != states.fireass or disy >= 0 or vsp >= 0)
{
	if disx > 0
		key_right = true;
	else
		key_left = true;
}
if abs(disx) > 200
	key_attack = true;

if state == states.fireass && collision_line(x, y, x, y - 400, obj_solid, false, false) && disy < 0
{
	if key_left
	{
		key_right = true;
		key_left = false;
	}
	else
	{
		key_right = false;
		key_left = true;
	}
}

if disy <= 0 && !scr_solid(x + xscale * 16, y + 1) && state != states.ladder
{
	key_jump = true;
	key_jump2 = true;
}

if disy < 0 or vsp < -1
{
	if instance_exists(obj_ladder) && state != states.ladder && disy < -200
	{
		var ladder = instance_nearest(x, y, obj_ladder);
		if ladder.y >= y - 280 && ladder.y < bbox_bottom
		{
			disx = ladder.x + 16 - x;
			
			key_attack = abs(disx) > 100;
			if abs(ladder.x - x) < 100
			{
				key_jump2 = true;
				key_jump = true;
			}
			if !grounded
				key_up = true;
			
			if disx != 0 && abs(disx) > 5
			{
				if disx > 0
				{
					key_left = false;
					key_right = true;
				}
				else if disx < 0
				{
					key_right = false;
					key_left = true;
				}
			}
		}
	}
	if instance_exists(obj_boilingsauce)
	{
		var sauce = instance_nearest(x, y, obj_boilingsauce);
		if sauce.y > bbox_bottom && sauce.y < bbox_bottom + 64 && distance_to_object(sauce) < 200
		{
			key_right = false;
			key_left = false;
			if sauce.bbox_right - 32 < x
				key_left = true;
			if sauce.bbox_left + 32 > x
				key_right = true;
			
			key_jump = false;
			key_jump2 = false;
		}
	}
	if state == states.ladder
		key_up = true;
}
if state == states.Sjumpprep
	key_up = false;
if !grounded && state != states.ladder
	key_jump2 = true;

if state == states.climbwall && scr_solid(x, y - 200) or disy < 0
	key_jump2 = true;

// necessary collisions
var ladder = instance_place(x, y, obj_ladder);
if ladder && state != states.ladder
{
	if key_up && ladderbuffer <= 0 && state != states.machslide
	{
		mach2 = 0
		state = states.ladder
		doorx = ladder.x + 16;
		key_jump = false;
	}
}
if state == states.ladder
{
	key_jump = false;
	key_jump2 = false;
}

// finally perform the actual player's step event
key_left *= -1;
key_left2 *= -1;
event_perform_object(obj_player, ev_step, 0);

// extra
flash = false;

shadowparticle--;
if shadowparticle <= 0
{
	with instance_create(x + random_range(-25, 25), y + random_range(-25, 45), obj_cloudeffect)
	{
		image_blend = other.shadowcolor;
		depth = other.depth - 1;
	}
	shadowparticle = 25;
}

