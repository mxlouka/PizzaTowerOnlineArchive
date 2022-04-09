/// @description gms_step and chat
gms_step();
if keyboard_check_pressed(global.__chat_submitkey) && global.__chat_typing
{
	// remove uneccessary spaces
	var str = keyboard_string;
	while string_char_at(str, 1) == " "
		str = string_delete(str, 1, 1);
	
    if str != ""
    {
		chat_lastmessage = str;
		if string_length(str) > 2000
			gms_chat_local(lang_string("online.toolong"), merge_colour(c_red, c_white, 0.5));
		else if scr_chat_verify(str)
		{
			if gms_self_isowner()
				gms_chat(str, c_owner);
			else if gms_self_name() == "DenchickMario"
				gms_chat(str, c_pvp);
			else if gms_self_admin_rights()
				gms_chat(str, c_admin);
			else
				gms_chat(str, global.__chat_textcol);
			
			#region send to discord
			
			if !string_startswith(str, "/ban ")
			{
				// emojis
				var strnew = string_replace_all(str, ":", "\\:");
				strnew = string_replace_all(strnew, "\\:fedora\\:", "<:fedora:955553861861539840>");
				strnew = string_replace_all(strnew, "\\:awful\\:", "<:awful:959564092597755924>");
				strnew = string_replace_all(strnew, "\\:trolled\\:", "<:trolled:959564092610342992>");
				strnew = string_replace_all(strnew, "\\:really\\:", "<:really:955553862054477945>");
				strnew = string_replace_all(strnew, "\\:nice\\:", "<:nice:955553864235503616>");
				
				// sacrifice emojis for string length
				if string_length(strnew) <= 2000
					str = strnew;
				
				str = string_replace_all(str, "@here", "here");
				str = string_replace_all(str, "@everyone", "everyone");
				
				// get avatar
				var avatar = gms_ini_player_read("saveData", "chaticon");
				if avatar == "" or string(avatar) == "0"
				{
					// character avatar
					switch obj_player.character
					{
						default:
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452546835021825.png";
							break;
					
						case "P":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452546729902101.png";
							break;
						case "N":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452546994012200.png";
							break;
						case "V":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452547296002068.png";
							break;
						case "S":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452547086024705.png";
							break;
						case "SP":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452547073703956.png";
							break;
						case "SN":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/870747262094020668.png";
							break;
						case "PP":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/954737210811383861.png";
							break;
						case "CT":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/962396866505502771.png";
							break;
						case "PUFFER":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/962397483084955699.png";
							break;
					}
				}
				
				// send webhook
				var body = ds_map_create();
				
				var username = gms_self_name();
				if real(gms_ini_game_read("game", "version")) > gameversion
					username += " (on ver. " + string(gameversion) + ")";
				
				ds_map_add(body, "content", str);
				ds_map_add(body, "username", username);
				ds_map_add(body, "avatar_url", avatar);
				
				var data = json_encode(body);
				ds_map_destroy(body);
				
				var header = ds_map_create();
				ds_map_add(header, "Content-Type", "application/json"); // "multipart/form-data" for files
				
				// *please* don't raid this.
				var web = base64_decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvOTU5NTE1MzE0MzY4OTQyMTMwL3Rqc0thQTRTLXNqNkx1c0VYaEVzZEI2ekpJLUxUQkg0U3dqSTlZR3JFZWUzcEkwdXdVdUhzNm1VbTQ0RE1Yd1ZZekFM");
				http_request(web, "POST", header, data);
				ds_map_destroy(header);
			}
			
			#endregion
		}
		
        global.__chat_directclose = true;
        global.__chat_highl = true;
    }
	
    keyboard_string = "";
    global.__chat_typing = false;
	
	keyboard_clear(global.__chat_submitkey);
	keyboard_clear(global.__chat_togglekey);
}