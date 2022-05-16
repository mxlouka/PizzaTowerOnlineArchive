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
}
else
	scr_soundeffect(sfx_pizzaface);

