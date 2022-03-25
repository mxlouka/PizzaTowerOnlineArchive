/// @description hats & reset choice
var _s = selarray[sel[0]][0];
if _s == "special1"
	spr_idle = spr_sausagemansmoked_grabbed;
else
	spr_idle = object_get_sprite(selarray[sel[0]][0]);

if spr_idle == spr_noisey_walk_NEW && global.gameplay == 0
	spr_idle = spr_noisey_walk;
if spr_idle == spr_charcherry_wait
	spr_idle = spr_charcherry_run;

selmin = 0;
selmax = array_length(selarray) - 1;
