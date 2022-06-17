function scr_sleep(ms)
{
	var time = current_time;
	
	if global.gameplay == 0
		do { } until (current_time - time) >= round(ms);
	
	return current_time - time;
}
