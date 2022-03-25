msg = "LEVEL BROWSER";

if (!check_online() or gms_ini_game_read("game", "leveleditor") == false)
&& !debug
	msg = "UNDER MAINTENANCE";
