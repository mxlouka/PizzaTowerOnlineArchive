//Kill
if instance_exists(baddieID)
{
	scr_soundeffect(sfx_killenemy)
	if global.gameplay == 0
		scr_sleep(50)
	
	repeat 3
		instance_create(x, y, obj_slapstar)
	repeat 4
		create_particle(x, y, particles.baddiegibs)
	
	instance_destroy(baddieID)
	instance_destroy()
}

