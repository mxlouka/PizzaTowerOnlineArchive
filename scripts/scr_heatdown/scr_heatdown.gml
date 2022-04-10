function scr_heatdown()
{
	global.baddiespeed = max(global.baddiespeed - 1, 1);
	
	if global.stylethreshold != 2
		global.baddiepowerup = false

	if global.stylethreshold < 2
	{
		global.baddierage = false
		with obj_heatafterimage
			visible = false
	}
	
	with obj_tv
	{
		message = "HEAT DOWN..."
		alarm[2] = 200
		showtext = true
	}
	
	with obj_stylebar
	{
		toggle = true
		alarm[0] = 5
	}
}

