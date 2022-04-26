if !debug
{
	if !check_online() or gms_ini_game_read("game", "leveleditor") == false
	{
		event_perform(ev_alarm, 2);
		exit;
	}
}

enum reqtypes
{
	read_paging,
	read_level,
	tp_level,
	
	login,
	register,
	upload,
	rate_level
}
enum menutypes
{
	menustart,
	menuonline,
	
	levelbrowser,
	leveldetails,
	
	login,
	register,
	upload,
	vote,
	listfiles,
	userinfo
}

records = undefined; // the level listing
showmissingchar = false;

yview = 0; // scrolling
yviewmax = 0;

menu = menutypes.menustart;

message = ""; // text at top
showtext = false;
xi = 960 / 2;
yi = -50;

page = 1;
paging_type = 3; // 0 for browse, 1 for featured, 2 for search, 3 for alternate
pagelast = 0;

request = ""; // the http request sent
requestype = 0;

loading = false; // loading wheelie thing
loadingrotation = 0;
scrolling = false;
viewpos = 0;

// search button
searchstring = "";
searchstring_real = "";
selectedsearch = false;

// password button
passwordstring = "";
selectedpassword = false;
registering = false;
passconfirm1 = "";

regedit = false;
if check_online()
{
	if gms_ini_player_exists("saveData", "regedit")
		regedit = gms_ini_player_read("saveData", "regedit");
	gms_chat_toggle(false);
}

// etc
textline = false;

response = "";
map = undefined;

// level details
level_id = undefined;
level_name = undefined;
level_desc = undefined;
level_string = undefined;
level_userid = undefined;
level_author = undefined;
level_created = undefined;

// login status
if !variable_global_exists("auth")
	global.auth = "";
userid = -1;

// level verification
gmsroom = -1;
beatlevel = false;
loadlist = [];

// other shit
with obj_player
	state = states.titlescreen;

global.pizzacoinstart = global.pizzacoin;
alarm[2] = 10;