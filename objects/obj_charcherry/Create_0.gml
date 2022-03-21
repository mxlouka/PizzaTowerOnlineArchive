event_inherited();

groundpound = false;
killreward = false;
stunnable = false;

grav = 0.5;
hsp = 0;
vsp = 0;
movespeed = 7
state = states.cherrywait
stunned = 0
alarm[0] = 150
roaming = true
collectdrop = 5
flying = false
straightthrow = false
cigar = false
cigarcreate = false
stomped = false
shot = false
thrown = false
reset = false
flash = false
landspr = spr_slimebounce
idlespr = spr_charcherry_wait
fallspr = spr_charcherry_run
stunfallspr = spr_charcherry_wait
walkspr = spr_charcherry_run
turnspr = spr_charcherry_run
recoveryspr = spr_charcherry_wait
grabbedspr = spr_charcherry_wait
scaredspr = spr_charcherry_wait

image_xscale = -1
hp = 1
slapped = false
grounded = true
birdcreated = false
boundbox = false
spr_dead = spr_charcherry_dead
important = false

heavy = false
depth = 0

paletteselect = 1
spr_palette = palette_cheeseslime

grabbedby = 0
momentum = 5

hitboxcreate = false
image_speed = 0.35
steppy = 0

stuntouchbuffer = 0

// death
custom_death_fnc = function()
{
	instance_create(x, y, obj_bombexplosion);
	instance_create(x, y, obj_bangeffect);
	
	with instance_create(x, y, obj_sausageman_dead)
		sprite_index = other.spr_dead;
}
