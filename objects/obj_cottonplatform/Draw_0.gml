img = (img + 0.05) % 2;
for (var i = 0; i < abs(image_xscale); i++)
{
	var left = 32;
	if i <= 0
		left = 0;
	if i >= abs(image_xscale) - 1
		left = 64;
	
	draw_sprite_part_ext(spr_cottonplat, img, left, 0, 32, 32, x + ((sign(image_xscale) * 32) * i), y, sign(image_xscale), sign(image_yscale), c_white, image_alpha);
}
