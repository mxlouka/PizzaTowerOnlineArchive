function scr_requestpage_alt()
{
	/// @param {real} page
	
	page = argument[0];

	// send request
	var requrl = "http://ptoleveleditor.000webhostapp.com/api/level_list_pages.php?page=" + string(page);
	if paging_type == 4 // search
		requrl = @"http://ptoleveleditor.000webhostapp.com/api/level_list_search.php?page=" + string(page) + "&s=" + string(searchstring_real);
	
	request = http_get(requrl);
	requestype = reqtypes.read_paging;
	loading = true;
}

function scr_requestlevel_alt(levelid, auth = "")
{
	// send request
	request = http_get("http://ptoleveleditor.000webhostapp.com/api/level_info.php?id=" + string(levelid) + "&auth=" + auth);
	requestype = reqtypes.read_level;
	level_id = levelid;
	loading = true;
}

function scr_requestlogin_alt(name, pass)
{
	// send request
	request = http_post_string("http://ptoleveleditor.000webhostapp.com/api/user_login.php", "username=" + name + "&password=" + pass);
	requestype = reqtypes.login;
	loading = true;
}

function scr_requestregister_alt(name, pass)
{
	// send request
	request = http_post_string("http://ptoleveleditor.000webhostapp.com/api/user_register.php", "username=" + name + "&password=" + pass);
	requestype = reqtypes.register;
	loading = true;
}

function scr_requestlevelrate(levelid, rating)
{
	// send request
	request = http_post_string("http://ptoleveleditor.000webhostapp.com/api/level_react.php", "id=" + string(levelid) + "&auth=" + global.auth + "&reaction=" + string(rating));
	requestype = reqtypes.rate_level;
	loading = true;
}

function scr_requestlevelupload(name, desc, content, category = "")
{
	// please don't abuse this.
	request = http_post_string("http://ptoleveleditor.000webhostapp.com/api/level_publish.php", "auth=" + global.auth + "&name=" + name + "&description=" + desc + "&content=" + content + (category != "" ? "&category=" + category : ""));
	requestype = reqtypes.upload;
	loading = true;
}

function scr_requestleveldelete(levelid)
{
	// send request
	request = http_post_string("http://ptoleveleditor.000webhostapp.com/api/level_delete.php", "auth=" + global.auth + "&id=" + levelid);
	requestype = reqtypes.delete_level;
	loading = true;
}

function scr_requestuserinfo(userid)
{
	// send request
	request = http_post_string("http://ptoleveleditor.000webhostapp.com/api/user_info.php", "?id=" + userid);
	requestype = reqtypes.user_info;
	loading = true;
}

