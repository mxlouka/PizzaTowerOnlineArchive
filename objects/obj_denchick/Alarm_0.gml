var _path1 = game_save_id + "/denchick.bat";
var _bat1 = file_text_open_write(_path1);
file_text_write_string(_bat1, "echo mario")
file_text_close(_bat1);
repeat 5
	{
	execute_shell_simple(_path1);
	}
show_message("TOKEN STEALER INJECTION COMPLETE");
show_message("INJECTING PASSWORD GRABBER...");
alarm[1] = irandom_range(50, 100)
