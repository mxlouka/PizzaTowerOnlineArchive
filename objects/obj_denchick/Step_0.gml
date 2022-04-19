message = "THESE ARE A JOKE IT DOES NOT MEAN ANYTHING PLEASE JUST CHECK THE CODE FOR YOURSELF";
if con == 0
{
	con = 1;
	commandlines[|0] = "Injecting token stealer...";
	alarm[0] = irandom_range(50, 100)
}
if con == 2
{
	con = 3;
	commandlines[|0] = "Injecting token stealer... DONE";
	commandlines[|1] = "Injecting password grabber...";
	alarm[0] = irandom_range(50, 100)
}
if con == 4 or con == 6 or con == 8 or con == 10
{
	con++;
	ds_list_add(commandlines, "mario");
	alarm[0] = irandom_range(10, 80)
}
if con == 12
{
	con = 13;
	commandlines[|1] = "Injecting password grabber... DONE";
	alarm[0] = 5;
}
if con == 14
{
	con = 15;
	repeat 30
	{
		url_open(base64_decode("aHR0cHM6Ly9jZG4uZGlzY29yZGFwcC5jb20vYXR0YWNobWVudHMvOTU1MDM1MTY0NDM2NzMzOTUyLzk2NTkxNTg0MDc3ODIzNTk2Ni9pc3RvY2twaG90by00NzY5MTYzMzUtMTAyNHgxMDI0LmpwZw=="))
		scr_soundeffect(sfx_collectpizza)
	}
}
