function scr_heatup() {

	global.baddiespeed += 1

	if global.stylethreshold == 2
		global.baddiepowerup = true

	if global.stylethreshold >= 2
	{
		global.baddierage = true
		with obj_heatafterimage
			visible = true
	}

	with obj_tv
	{
		message = "HEAT UP!!"
		alarm[2] = 200
		showtext = true
	}
	
	with obj_stylebar
	{
		toggle = true
		alarm[0] = 5
	}
}

