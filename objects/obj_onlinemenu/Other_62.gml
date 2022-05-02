if live_call() return live_result;

if ds_map_find_value(async_load, "id") == request
{
	if async_load[?"status"] == 0
	{
		request = "";
		loading = false;
		asyncresult = ds_map_find_value(async_load, "result");
		
		map = json_decode(asyncresult);
		if map == -1
		{
			trace(asyncresult);
			with obj_roomname
			{
				showtext = true;
				message = lang_string("editor.menu.async.invalid");
				alarm[0] = 200;
			}
			exit;
		}
		
		if requestype == reqtypes.read_level
		or requestype == reqtypes.tp_level
		{
			level_name = ds_map_find_value(map, "name");
			
			level_desc = ds_map_find_value(map, "description");
			if level_desc != undefined
			{
				level_desc = string_replace_all(string(level_desc), "&amp;", "&");
				level_desc = string_replace_all(level_desc, "&lt;", "<");
				level_desc = string_replace_all(level_desc, "&gt;", ">");
				level_desc = string_replace_all(level_desc, "&quot;", "\"");
				level_desc = string_replace_all(level_desc, "\\", "");
			}
			
			level_string = ds_map_find_value(map, "levelString");
			level_userid = ds_map_find_value(map, "userid");
			level_author = ds_map_find_value(map, "author");
			level_created = ds_map_find_value(map, "date");
			level_category = ds_map_find_value(map, "category");
		}
		
		if requestype == reqtypes.read_paging
		{
			var records_get = ds_map_find_value(map, "records");
			var paging_get = ds_map_find_value(map, "paging");
			
			if records_get != undefined && paging_get != undefined
			{
				var paging_last = ds_map_find_value(paging_get, "last");
				var paginglast_get = page;
				
				if paging_last != undefined && string_digits(string(paging_last)) != ""
					paginglast_get = real(string_replace(paging_last, "https:\/\/ptoleveleditor.000webhostapp.com\/api\/level_list_pages?level=", ""));
				
				records = records_get;
				pagelast = paginglast_get;
				yview = 0;
			}
			else
			{
				pagelast = 0;
				
				showtext = true;
				message = lang_string("editor.menu.async.unexpected");
				alarm[0] = 200;
			}
		}
		
		if requestype == reqtypes.login
		{
			var auth_get = ds_map_find_value(map, "auth");
			var userid_get = ds_map_find_value(map, "id");
			
			if auth_get != undefined
			{
				global.auth = auth_get;
				userid = userid_get;
			}
		}
		
		if requestype == reqtypes.register
		{
			passwordstring = "";
			selectedpassword = false;
			registering = false;
			
			var auth_get = ds_map_find_value(map, "auth");
			var userid_get = ds_map_find_value(map, "id");
			
			if auth_get != undefined
			{
				global.auth = auth_get;
				userid = userid_get;
			}
		}
		
		if requestype == reqtypes.tp_level
		{
			room_goto(custom_lvl_room);
			if obj_gms.__user != noone
				obj_gms.alarm[0] = 10;
			else
			{
				scr_playerreset();
				with obj_player
				{
					x = global.gottp[1];
					y = global.gottp[2];
					targetDoor = "none";
				}
			}
		}
		
		if requestype == reqtypes.rate_level
			menu = menutypes.leveldetails;
		
		if requestype == reqtypes.upload
		{
			var levelid = ds_map_find_value(map, "id");
			if levelid != undefined
			{
				level_string = undefined;
				menu = menutypes.leveldetails;
				scr_requestlevel_alt(levelid);
			}
		}
		
		if requestype == reqtypes.delete_level
		{
			records = undefined;
			menu = menutypes.levelbrowser;
			scr_requestpage_alt(page);
		}
		
		if requestype == reqtypes.user_info
		{
			user_name = map[?"username"];
			user_lastlogin = map[?"lastlogin"];
			user_created = map[?"created"];
			user_admin = map[?"admin"];
			
			var records_get = map[?"levels"];
			records = records_get;
			yview = 0;
		}
		
		var msg = ds_map_find_value(json_decode(asyncresult), "message");
		if msg != undefined && string(msg) != ""
		{
			showtext = true;
			message = string_upper(string(msg));
			alarm[0] = 200;
		}
	}
	else if async_load[?"status"] < 0
	{
		showtext = true;
		message = "Server error!";
		alarm[0] = 200;
		loading = false;
		trace(async_load[?"http_status"]);
	}
}

