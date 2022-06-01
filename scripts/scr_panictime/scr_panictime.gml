function scr_panictime()
{
	// set global timer based on stage
	var roomname = room_get_name(room);
	if string_endswith(roomname, "_NEW")
		roomname = string_replace(roomname, "_NEW", "");
	
	switch roomname
	{
		default:
			global.minutes = 2
			global.seconds = 59
			break
			
		case "entrance_10":
			global.minutes = 2
			global.seconds = 30
			break
			
		case "medieval_10":
			global.minutes = 2
			global.seconds = 15
			break
			
		case "ruin_11":
			global.minutes = 2
			global.seconds = 59
				
			if global.gameplay != 0
				global.minutes = 3
			break
			
		case "dungeon_10":
			global.minutes = 4
			global.seconds = 30
			break
	
		case "chateau_6":
			global.minutes = 3
			global.seconds = 15
			break
	
		case "strongcold_1":
			global.minutes = 3
			global.seconds = 59
			break
	
		case "dragonlair_1":
			global.minutes = 0
			global.seconds = 59
			break
	
		case "floor1_room11":
			global.minutes = 2
			global.seconds = 59
			break
	
		case "graveyard_6":
			global.minutes = 3
			global.seconds = 59
			break
	
		case "farm_11":
			global.minutes = 3
			global.seconds = 59
			break
			
		case "ufo_12":
			global.minutes = 2
			global.seconds = 30
			break
			
		case "beach_13":
			global.minutes = 3
			global.seconds = 59
			break
			
		case "forest_5":
			global.minutes = 3
			global.seconds = 30
			break
			
		case "kungfu_10":
			global.minutes = 6
			global.seconds = 30
			break
			
		case "minigolf_8":
			global.minutes = 7
			global.seconds = 30
			break
			
		case "space_9":
			global.minutes = 5
			global.seconds = 30
			break
			
		case "mansion_7":
			global.minutes = 5
			global.seconds = 30
			break
			
		case "factory_10":
			global.minutes = 6
			global.seconds = 30
			break
			
		case "freezer_3":
			global.minutes = 5
			global.seconds = 30
			break
			
		case "war_1":
			global.minutes = 8
			global.seconds = 59
			break
			
		case "exit_1":
			global.minutes = 9
			global.seconds = 59
			break
			
		case "kidsparty_lastroom":
			global.minutes = 3
			global.seconds = 30
			break
			
		case "floor4_roomtreasure":
			global.minutes = 2
			global.seconds = 30
			break
			
		case "floor3_roomtreasure":
			global.minutes = 2
			global.seconds = 30
			break
			
		case "floor2_roomtreasure":
			global.minutes = 2
			global.seconds = 30
			break

		case "floor5_roomtreasure":
			global.minutes = 1
			global.seconds = 59
			break
			
		case "golf_roomtreasure":
			global.minutes = 1
			global.seconds = 59
			break
			
		case "etb_8":
			global.minutes = 2
			global.seconds = 59
			break
				
		case "cotton_12":
			global.minutes = 3
			global.seconds = 59
			break
			
		case "entryway_11":
			global.minutes = 2
			global.seconds = 29
			break
			
		case "custom_lvl_room":
			with obj_destroyableescape
				alarm[0] = 1
			with obj_destroyable2escape
				alarm[0] = 1
			with obj_destroyable3escape
				alarm[0] = 1
			with obj_destroyable2_bigescape
				alarm[0] = 1
			global.minutes = global.editorminutes
			global.seconds = global.editorseconds
			break
	}
	
	// extend timer in the careful modifiers
	if global.modifier == mods.no_toppings or global.modifier == mods.pacifist
	{
		global.minutes *= 1.5;
		global.minutes = floor(global.minutes);
		
		if global.seconds == 30
			global.seconds = 29;
			
		global.seconds *= 2;
		if global.seconds >= 60
		{
			global.minutes += 1;
			global.seconds -= 60;
		}
			
		if global.seconds > 0 && global.seconds < 20
			global.seconds = 15;
		if global.seconds > 20 && global.seconds < 40
			global.seconds = 29;
		if global.seconds > 40
			global.seconds = 59;
	}
}