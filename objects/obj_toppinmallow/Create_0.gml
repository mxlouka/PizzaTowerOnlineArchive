event_inherited();
if global.gameplay == 0
{
	spr_intro = spr_toppinmallow_run;
	spr_idle = spr_toppinmallow;
	spr_run = spr_toppinmallow_run;
	spr_panic = spr_toppinmallow_run;
	spr_panicidle = spr_toppinmallow;
}
else
{
	spr_intro = spr_toppinmallow_intro_NEW;
	spr_idle = spr_toppinmallow_NEW;
	spr_run = spr_toppinmallow_run_NEW;
	spr_panic = spr_toppinmallow_run_NEW;
	spr_panicidle = spr_toppinmallow_panic_NEW;
	yoffset = 0;
}

spr_intro_strongcold = spr_toppinmallow_run;
spr_idle_strongcold = spr_toppinmallow;
spr_run_strongcold = spr_toppinmallow_run;
spr_panic_strongcold = spr_toppinmallow;
spr_panicidle_strongcold = spr_toppinmallow_run;
