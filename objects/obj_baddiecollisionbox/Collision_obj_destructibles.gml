if instance_exists(baddieID) && baddieID.thrown
{
	if scr_stylecheck(2)
		other.hsp2 = baddieID.hsp / 3;
	instance_destroy(other);
}
