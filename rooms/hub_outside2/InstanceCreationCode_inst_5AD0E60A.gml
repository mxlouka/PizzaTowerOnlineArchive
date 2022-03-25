targetRoom = editor_entrance;

if (!check_online() or gms_ini_game_read("game", "leveleditor") == false)
&& !debug
	instance_change(obj_doorblocked, true);
