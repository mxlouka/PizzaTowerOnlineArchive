/// @param {real} page
function scr_requestpage_alt()
{
	page = argument[0];

	// send request
	var requrl = "http://ptoleveleditor.000webhostapp.com/api/level_list_pages.php?page=" + string(page);
	if paging_type == 4 // search
		requrl = @"http://ptoleveleditor.000webhostapp.com/api/level_list_search.php?page=" + string(page) + "&s=" + string(searchstring_real);
	
	request = http_get(requrl);
	requestype = reqtypes.read_paging_alt;
	loading = true;
}

/// @param {real} id
function scr_requestlevel_alt()
{
	levelid = argument[0];

	// send request
	request = http_get("http://ptoleveleditor.000webhostapp.com/api/level_info.php?id=" + string(levelid));
	requestype = reqtypes.read_level_alt;
	level_id = levelid;
	loading = true;
}

function scr_requestlogin_alt(name, pass)
{
	// send request
	request = http_post_string("http://ptoleveleditor.000webhostapp.com/api/user_login.php", "username=" + name + "&password=" + pass);
	requestype = reqtypes.login_alt;
	loading = true;
}

function scr_requestregister_alt(name, pass)
{
	// send request
	request = http_post_string("http://ptoleveleditor.000webhostapp.com/api/user_register.php", "username=" + name + "&password=" + pass);
	requestype = reqtypes.register_alt;
	loading = true;
}

