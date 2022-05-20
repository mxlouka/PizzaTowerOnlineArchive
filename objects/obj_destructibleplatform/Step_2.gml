if place_meeting(x, y, obj_otherplayer) && !falling
	image_alpha = 0.5;
else
	image_alpha = 1;

if floor(image_index) >= image_number - 1
{
	if sprite_index == spr_idle
	{
	    sprite_index = spr_dead;
	    falling = true;
	    x = -100;
	    y = -100;
	}
	else if sprite_index == spr_reform
	{
	    falling = false;
	    sprite_index = spr_idle;
	    image_index = 0;
	    image_speed = 0;
	}
}
if sprite_index == spr_dead && reset > 0
	reset--;

if reset <= 0 && !place_meeting(xstart, ystart, obj_player)
&& !place_meeting(xstart, ystart, obj_pizzaballOLD) && !place_meeting(xstart, ystart, obj_pizzaball)
{
	reset = 100;
	visible = true;
	image_speed = 0.35;
	falling = false;
	x = xstart;
	y = ystart;
	sprite_index = spr_reform;
}

