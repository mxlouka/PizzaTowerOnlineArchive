scr_getinput(true);
xoffset = lerp(xoffset, 0, 0.25);
yoffset = lerp(yoffset, 0, 0.25);

// change the palette
if con == 1
	exit;

if key_start or key_slap2
{
	keyboard_clear(global.key_start);
	keyboard_clear(global.key_slap);
	
	scr_soundeffect(sfx_enemyprojectile);
	con = 1;
	t = 0;
	exit;
}

// song select
if (key_up2 or (holdt == 0 && key_up))
{
	scr_soundeffect(sfx_step);
	sel[1] -= 1;
	if sel[1] < selmin
		sel[1] = selmax;
	
	yoffset = -100;
	
	if holdt == -1
		holdt = 30;
	else
		holdt = 3;
}
else if (key_down2 or (holdt == 0 && key_down))
{
	scr_soundeffect(sfx_step);
	sel[1] += 1;
	if sel[1] > selmax
		sel[1] = selmin;
	
	yoffset = 100;
	
	if holdt == -1
		holdt = 30;
	else
		holdt = 3;
}
sel[1] = clamp(sel[1], selmin, selmax);

if -key_up + key_down == 0
	holdt = -1;
else if holdt > 0
	holdt--;

// game
if -key_left2 && sel[0] > 0
{
	sel[1] = 0;
	
	scr_soundeffect(sfx_step);
	sel[0] -= 1;
	xoffset = -100;
	
	event_user(0);
}
else if key_right2 && sel[0] < array_length(gamearray) - 1
{
	sel[1] = 0;
	
	scr_soundeffect(sfx_step);
	sel[0] += 1;
	xoffset = 100;
	
	event_user(0);
}

// play the song
if key_jump
{
	keyboard_clear(global.key_jump);
	event_user(1);
}

