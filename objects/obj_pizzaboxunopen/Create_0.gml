image_speed = 0.35;
depth = 60;
if scr_depthcheck()
	depth += 100;

createdpizza = false;
content = obj_pizzakinshroom;

spr_closed = spr_pizzaboxunopen;
spr_open = spr_pizzaboxopen;
if check_sugary()
{
	spr_closed = spr_pizzaboxunopen_ss;
	spr_open = spr_pizzaboxopen_ss;
}
sprite_index = spr_closed;

