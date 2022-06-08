function sh_panic(args)
{
	if !WC_debug
		return "You do not have permission to use this command";
	
	var togglepanic = !global.panic;
	if array_length(args) > 1
	{
		if args[1] == "true" or args[1] == "1"
			togglepanic = true;
		else if args[1] == "false" or args[1] == "0"
			togglepanic = false;
		else
			return "Invalid argument: " + args[1];
	}
	
	var minutes = undefined, seconds = undefined;
	if array_length(args) > 2
	{
		if string_is_number(args[2])
			minutes = real(args[2]);
		else
			return "Minutes parameter should be a valid number"
	}
	if array_length(args) > 3
	{
		if string_is_number(args[3])
			seconds = real(args[3]);
		else
			return "Seconds parameter should be a valid number"
	}
	
	if togglepanic
	{
		// activate pizza time
		with instance_create(room_width, room_height + 2000, obj_hungrypillar)
		{
			event_perform(ev_destroy, 0);
			instance_destroy(id, false);
		}
		
		// set time
		if minutes != undefined
		{
			global.minutes = minutes;
			global.seconds = 0;
		}
		if seconds != undefined
			global.seconds = seconds;
		
		global.wave = 0;
		global.maxwave = max((global.minutes * 60 + global.seconds) * 60, 1);
	}
	else
	{
		// it is no longer pizza time
		with obj_camera
		{
			alarm[1] = -1;
			alarm[2] = -1;
		}
		global.panic = false;
		
		if !audio_is_playing(global.jukebox)
		{
			audio_stop_sound(global.music);
			with obj_music
				event_perform(ev_alarm, 1);
		}
	}
}
function meta_panic()
{
	return {
		description: "toggle it's pizza time on or off",
		arguments: ["<active>", "<minutes>", "<seconds>"],
		suggestions: [
			["true", "false"],
			[],
			[],
		],
		argumentDescriptions: [
			"whether to toggle escape on or off. true means on, false means off",
			"(optional) set minutes for the escape",
			"(optional) set seconds for the escape",
		],
	}
}
