maxspeed = 1
image_speed = 0.35
depth = -5

x = room_width / 2
y = -100

alarm[1] = 10

sugary = check_sugary();
if sugary
{
	sprite_index = spr_coneball;
	scr_soundeffect(sfx_coneball);
	
	reset_pos = function()
	{
		x = obj_player.x + choose(800, -800);
		y = obj_player.y + choose(800, -800);
		
		xx = x - _camx;
		yy = y - _camy;
	}
}
else
{
	scr_soundeffect(sfx_pizzaface);
	
	if global.gameplay != 0
	{
		image_alpha = 0
		x = obj_player.x
		y = obj_player.y
	}
}

siner = room_speed * random_range(4, 8);
attack = 0;
xx = x;
yy = y;

