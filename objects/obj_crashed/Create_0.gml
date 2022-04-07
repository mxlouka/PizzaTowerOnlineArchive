if !variable_global_exists("crashed")
{
	instance_destroy();
	exit;
}

scr_soundeffect(sfx_pephurt);

crashtext = lang_string("general.crash");
if irandom_range(1, 100) == 5 // 1% chance
	crashtext = "OOPSIE WOOPSIE!! Uwu We made a fucky wucky";

// do not judge my intentions

fading = false;
image_alpha = 0;

