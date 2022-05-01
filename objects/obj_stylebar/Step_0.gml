// disable heat in old
if scr_stylecheck(0)
{
	global.style = 0;
	global.stylethreshold = 0;
	exit;
}

// heat up
if global.style > 55 && global.stylethreshold < 3
{
    global.stylethreshold += 1;
    global.style = global.style - 55;
    scr_heatup()
	
	if global.stylethreshold == 3 && scr_stylecheck(2)
		with obj_baddie flash = true;
}

// heat down
if global.style < 0 && global.stylethreshold != 0
{
    global.stylethreshold -= 1;
    global.style = global.style + 55;
    scr_heatdown()
	
	if global.stylethreshold == 2 && scr_stylecheck(2)
		with obj_baddie flash = true;
}

// clamp heat
if global.style < 0 && global.stylethreshold == 0
    global.style = 0
if global.stylethreshold == 3 && global.style > 55
    global.style = 55

