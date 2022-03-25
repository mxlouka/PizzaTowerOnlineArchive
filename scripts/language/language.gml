// language
function lang_string(str)
{
	var ret = global.langmap[? str];
	if is_undefined(ret)
		ret = str;
	
	return ret;
}

function lang_sprite(spr)
{
	var ret = global.langspr[? spr];
	if is_undefined(ret)
		ret = spr;
	
	return ret;
}

function lang_load(lang)
{
	global.langmap = ds_map_create();
	global.langspr = ds_map_create();
	
	#region english
	
	if lang == "en"
	{
		// SPRITES
		
		
		// TEXT
		ds_map_add(global.langmap, "load.loading", "LOADING");
		ds_map_add(global.langmap, "load.txgrp", "PRE-LOADING SPRITES");
		ds_map_add(global.langmap, "load.unusual", "This is taking unusually long to load.\nEither wait or restart the game.");
		
		ds_map_add(global.langmap, "general.wc", "Welcome to the developer console");
		ds_map_add(global.langmap, "general.crash", "The game crashed last time.");
		ds_map_add(global.langmap, "general.crash.con", "Press start to play");
		ds_map_add(global.langmap, "general.crashed", "The game crashed! longMessage:\n\n");
		ds_map_add(global.langmap, "general.drm", "Congratulations!\nYou played yourself\n\nPress R to restart the game");
		ds_map_add(global.langmap, "general.drm.wait", "(Restarting)");
		ds_map_add(global.langmap, "drpc.nullino", "Playing as who?");
		
		ds_map_add(global.langmap, "disclaimer.title", "DISCLAIMER");
		ds_map_add(global.langmap, "disclaimer.continue", "Press ENTER to play");
		ds_map_add(global.langmap, "disclaimer.outdated", "Outdated version!\n\nUsually this means something really bad happened and\nthe creator wants to block an older version from working.");
		ds_map_add(global.langmap, "disclaimer.error", "Server error!\nI can't do anything about this, so just wait and try again.");
		ds_map_add(global.langmap, "disclaimer.errornodrm", "Status not success, error.\nServers might be unavailable.\n\nRunning in offline mode.");
		ds_map_add(global.langmap, "disclaimer.offline", "You have stumbled upon the asshole version of this disclaimer.\n\nYou can't start the game offline.\nConnect to the internet, then we're talkin'.");
		ds_map_add(global.langmap, "disclaimer.offlinenodrm", "You are playing offline.\nSome features will be disabled.");
		
		// options 1
		ds_map_add(global.langmap, "options.fullscreen", "FULLSCREEN");
		ds_map_add(global.langmap, "options.on", "ON");
		ds_map_add(global.langmap, "options.off", "OFF");
		ds_map_add(global.langmap, "options.resolution", "RESOLUTION");
		ds_map_add(global.langmap, "options.keyconfig", "KEY CONFIG");
		ds_map_add(global.langmap, "options.soundconfig", "SOUND CONFIG");
		ds_map_add(global.langmap, "options.otherconfig", "OTHER CONFIG");
		
		ds_map_add(global.langmap, "options.sound.master", "MASTER VOLUME");
		ds_map_add(global.langmap, "options.sound.music", "MUSIC VOLUME");
		ds_map_add(global.langmap, "options.sound.sound", "SOUND VOLUME");
		ds_map_add(global.langmap, "options.sound.mach", "MACH SOUND");
		ds_map_add(global.langmap, "options.sound.machold", "OLD");
		ds_map_add(global.langmap, "options.sound.machnew", "NEW");
		ds_map_add(global.langmap, "options.sound.game", "MUSIC TYPE");
		ds_map_add(global.langmap, "options.sound.normal", "TOWER");
		ds_map_add(global.langmap, "options.sound.castle", "CASTLE");
		
		ds_map_add(global.langmap, "options.erase.text", "ARE YOU SURE?");
		ds_map_add(global.langmap, "options.erase.no", "NO");
		ds_map_add(global.langmap, "options.erase.yes", "YES");
		
		// other options
		ds_map_add(global.langmap, "options.other.erase", "Erase Game");
		ds_map_add(global.langmap, "options.other.gameplay", "Gameplay Style");
		ds_map_add(global.langmap, "options.other.wavybg", "Escape - Wavy Background");
		ds_map_add(global.langmap, "options.other.blur", "Escape - Motion Blur");
		ds_map_add(global.langmap, "options.other.shaky", "Escape - Screen Shake");
		ds_map_add(global.langmap, "options.other.panicbg", "Escape - Backgrounds");
		ds_map_add(global.langmap, "options.other.afterimage", "Visual - Fancy Afterimages");
		ds_map_add(global.langmap, "options.other.demo3", "Visual - Fancy Debris");
		ds_map_add(global.langmap, "options.other.playernames", "Online - Show Names");
		ds_map_add(global.langmap, "options.other.chatbubbles", "Online - Chat Bubbles");
		ds_map_add(global.langmap, "options.other.synceffects", "Online - Sync Effects");
		ds_map_add(global.langmap, "options.other.fuckoffptd", "Online - Streamer Mode");
		ds_map_add(global.langmap, "options.other.onlinepvp", "Online - PvP");
		ds_map_add(global.langmap, "options.other.drpc", "Other - Discord Rich Presence");
		ds_map_add(global.langmap, "options.other.fpscount", "Other - FPS Counter");
		ds_map_add(global.langmap, "options.other.camsmooth", "Other - Smooth Camera");
		ds_map_add(global.langmap, "options.other.screenshader", "Other - Screen Shader");
		ds_map_add(global.langmap, "options.other.pauseblur", "Other - Pause Blur");
		
		// other options descriptions and stuff
		ds_map_add(global.langmap, "options.other.erase.desc", "All your progress, gone. Game will restart.");
		
		ds_map_add(global.langmap, "options.other.gameplay.desc", "The game changed a lot throughout development.\nSome people may prefer older moveset and music.");
		ds_map_add(global.langmap, "options.other.gameplay.nonpatron", "This option is reserved for Patrons only.");
		ds_map_add(global.langmap, "options.other.gameplay.old", "OLD");
		ds_map_add(global.langmap, "options.other.gameplay.remix", "REMIX");
		ds_map_add(global.langmap, "options.other.gameplay.final", "FINAL");
		ds_map_add(global.langmap, "options.other.gameplay.old.desc", "Moveset mostly from before the April 2021 Patreon build.");
		ds_map_add(global.langmap, "options.other.gameplay.final.desc", "Recreation of the final version of the game.");
		ds_map_add(global.langmap, "options.other.gameplay.remix.desc", "Makes the \"perfect mix\" between the other two gameplay styles. (WIP)\nYou can suggest changes for this style in the Discord.");
		
		ds_map_add(global.langmap, "options.other.wavybg.title", "WAVY BACKGROUND");
		ds_map_add(global.langmap, "options.other.wavybg.desc", "When it's Pizza Time, the background slowly distorts\nand tints red depending on your time left.");
		ds_map_add(global.langmap, "options.other.wavybg.locked", "Shit Graphix mode on. This option is locked.");
		ds_map_add(global.langmap, "options.other.wavybg.shaderfail", "Shaders not compiled.\nPlease restart the game.");
		
		ds_map_add(global.langmap, "options.other.blur.title", "MOTION BLUR");
		ds_map_add(global.langmap, "options.other.blur.desc", "When it's Pizza Time, the screen will have motion blur.\nIt gets more intense depending on your time left.");
		
		ds_map_add(global.langmap, "options.other.shaky.title", "ESCAPE SHAKE");
		ds_map_add(global.langmap, "options.other.shaky.desc", "When it's Pizza Time, the screen will shake.");
		
		ds_map_add(global.langmap, "options.other.panicbg.title", "ESCAPE BACKGROUND");
		ds_map_add(global.langmap, "options.other.panicbg.desc", "When it's Pizza Time, some backgrounds will change.");
		
		ds_map_add(global.langmap, "options.other.afterimage.title", "FANCY AFTERIMAGES");
		ds_map_add(global.langmap, "options.other.afterimage.desc", "Applies your current palette to the colored afterimages.\nThis is a nearly unnoticeable detail that just tanks on performance.\nGood to have the option, though.");
		
		ds_map_add(global.langmap, "options.other.demo3.title", "TILED DEBRIS");
		ds_map_add(global.langmap, "options.other.demo3.desc", "Secret tile particles will show their respective\ntiles on them instead of a generic block's.");
		
		ds_map_add(global.langmap, "options.other.playernames.title", "SHOW NAMES");
		ds_map_add(global.langmap, "options.other.playernames.desc", "Show other people's usernames when playing online.");
		ds_map_add(global.langmap, "options.other.playernames.example", "Player");
		
		ds_map_add(global.langmap, "options.other.chatbubbles.title", "CHAT BUBBLES");
		ds_map_add(global.langmap, "options.other.chatbubbles.desc", "Show other people's last messages when they chat.");
		ds_map_add(global.langmap, "options.other.chatbubbles.example", "Hello what are your thoughts on Big Chungus");
		
		ds_map_add(global.langmap, "options.other.onlinepvp.title", "PVP");
		ds_map_add(global.langmap, "options.other.onlinepvp.desc", "Attack other players. The other player will need PVP enabled too.");
		
		ds_map_add(global.langmap, "options.other.synceffects.title", "SYNC EFFECTS");
		ds_map_add(global.langmap, "options.other.synceffects.desc", "Sync effects like afterimages or taunts in online mode.");
		
		ds_map_add(global.langmap, "options.other.fuckoffptd.title", "STREAMER MODE");
		ds_map_add(global.langmap, "options.other.fuckoffptd.desc", "Replaces *most* player names with their player IDs.");
		ds_map_add(global.langmap, "options.other.fuckoffptd.example1", "COOLSKELETON95");
		ds_map_add(global.langmap, "options.other.fuckoffptd.example2", "Player72103");
		
		ds_map_add(global.langmap, "options.other.drpc.title", "RICH PRESENCE");
		ds_map_add(global.langmap, "options.other.drpc.desc", "Show what exactly you are doing in-game in your Discord status.");
		ds_map_add(global.langmap, "options.other.drpc.example1", "In the titlescreen");
		ds_map_add(global.langmap, "options.other.drpc.example2", "boring shit");
		
		ds_map_add(global.langmap, "options.other.fpscount.title", "FPS COUNTER");
		ds_map_add(global.langmap, "options.other.fpscount.desc", "Shows an FPS counter at the bottom right of the screen.");
		
		ds_map_add(global.langmap, "options.other.camsmooth.title", "SMOOTH CAMERA");
		ds_map_add(global.langmap, "options.other.camsmooth.desc", "Smooths out the camera movement, just for fun.\nIf you unironically use this you are sick.");
		
		ds_map_add(global.langmap, "options.other.pauseblur.title", "PAUSE BLUR");
		ds_map_add(global.langmap, "options.other.pauseblur.desc", "Makes the pause menu background a blur effect.\nCauses mild lag.");
		
		ds_map_add(global.langmap, "options.other.screenshader.title", "SCREEN SHADER");
		ds_map_add(global.langmap, "options.other.screenshader.desc", "Full screen shader effect.");
		
		// manual
		ds_map_add(global.langmap, "manual.welcome", "Welcome to the Pizza Tower ONLINE manual!");
		
		ds_map_add(global.langmap, "manual.controls", "Controls");
		ds_map_add(global.langmap, "manual.controls.content", "You can see and change the controls in the options,\nbut there are extra controls exclusive to the mod:\n\n- T to open the chat\n- ENTER to begin typing and again to send a message\n- ESCAPE to exit the chat, if it's open");
		
		ds_map_add(global.langmap, "manual.commands", "Online - Chat Commands");
		ds_map_add(global.langmap, "manual.commands.content", "There are some commands that can be used in chat:\n\n/list - Lists all players that are currently in-game\n/t - Toggles a mini-chat in the bottom left corner of the screen\n/ping - Pongs you back\n/dance - Dance");
		
		ds_map_add(global.langmap, "manual.rules", "Online - Rules");
		ds_map_add(global.langmap, "manual.rules.content", "Of course, every online game has rules to follow:");
		ds_map_add(global.langmap, "manual.rules.content2", "- Don't spam (1 minute auto-mute)\n\n- Don't swear\n    (the word will change to *** for others)\n\n- Don't mod the game\n    (Except simple sprite and music changes)\n\n- When recording footage, please enable\n  streamer mode in the OTHER OPTIONS menu");
		
		ds_map_add(global.langmap, "manual.lapping", "Lapping");
		ds_map_add(global.langmap, "manual.lapping.content", "Some levels have a \"lap\" room that can be accessed in the OLD gameplay\nstyle by taunting on the left-most wall of the first room in the level.\n\nThe lap room has a big pizza portal inside. In Pizza Time, you can enter it,\nputting you back at the end of the level, and respawning all the enemies.\n\nAt the expense of a tighter time limit, you can get a lot of points from lapping.");
		
		ds_map_add(global.langmap, "manual.credits", "Credits");
		ds_map_add(global.langmap, "manual.credits.fuckoffptd", "You can't see the credits\nin streamer mode. For safety.");
		
		// prelogin
		ds_map_add(global.langmap, "prelogin.offline", "Offline");
		ds_map_add(global.langmap, "prelogin.online", "Online");
		ds_map_add(global.langmap, "prelogin.nonet", "Connect To Network");
		ds_map_add(global.langmap, "prelogin.skip", "SKIP");
		ds_map_add(global.langmap, "prelogin.loading", "Loading");
		ds_map_add(global.langmap, "prelogin.loadfail", "Can't Connect To Network");
		ds_map_add(global.langmap, "prelogin.back", "Back");
		
		// logging in
		ds_map_add(global.langmap, "login.headlogin", "LOGIN");
		ds_map_add(global.langmap, "login.headreg", "REGISTER");
		ds_map_add(global.langmap, "login.login", "Login");
		ds_map_add(global.langmap, "login.register", "Register");
		ds_map_add(global.langmap, "login.cancel", "Cancel");
		ds_map_add(global.langmap, "login.username", "Username");
		ds_map_add(global.langmap, "login.password", "Password");
		ds_map_add(global.langmap, "login.email", "E-mail");
		ds_map_add(global.langmap, "login.passrepeat", "Repeat password");
		ds_map_add(global.langmap, "login.buildtime", "Build datetime");
		ds_map_add(global.langmap, "login.wait", "Wait...");
		
		// online messages
		ds_map_add(global.langmap, "online.disconnected", "Disconnected?!");
		ds_map_add(global.langmap, "online.reconnecting", "Reconnecting...");
		ds_map_add(global.langmap, "online.outdated", "Outdated Version!");
		ds_map_add(global.langmap, "online.loggedout", "Logged Out");
		ds_map_add(global.langmap, "online.chat", "Press ENTER to start typing, and again to send\nPress ESCAPE to exit the chat");
		ds_map_add(global.langmap, "online.toolong", "Message length must be below 2000 characters long");
		ds_map_add(global.langmap, "online.global", "Global Message");
		ds_map_add(global.langmap, "online.global.says", "says...");
		ds_map_add(global.langmap, "online.global.error", "(error)");
		ds_map_add(global.langmap, "online.playersonline", " Players Online");
		ds_map_add(global.langmap, "online.playeronline", " Player Online");
		
		// level editor
		ds_map_add(global.langmap, "editor.menu.online", "Online");
		ds_map_add(global.langmap, "editor.menu.load", "Load");
		ds_map_add(global.langmap, "editor.menu.build", "Build");
		ds_map_add(global.langmap, "editor.menu.back", "Back");
		ds_map_add(global.langmap, "editor.menu.wip", "Unfinished!");
		ds_map_add(global.langmap, "editor.menu.filefilter", "Level File (*.ptlv)|*.ptlv|All Files (*.*)|*.*");
		ds_map_add(global.langmap, "editor.menu.loadtitle", "Load Level");
		ds_map_add(global.langmap, "editor.menu.savetitle", "Download Level");
		ds_map_add(global.langmap, "editor.menu.online.official", "Browse");
		ds_map_add(global.langmap, "editor.menu.online.featured", "Featured");
		ds_map_add(global.langmap, "editor.menu.online.pto", "PTONLINE");
		ds_map_add(global.langmap, "editor.menu.search.preid", "ID, ");
		ds_map_add(global.langmap, "editor.menu.search.prelikes", " LIKES, ");
		ds_map_add(global.langmap, "editor.menu.search.predislikes", " DISLIKES, ");
		ds_map_add(global.langmap, "editor.menu.search.preby", "BY, ");
		ds_map_add(global.langmap, "editor.menu.search.preuserid", "USERID, ");
		ds_map_add(global.langmap, "editor.menu.search.page1", "Page ");
		ds_map_add(global.langmap, "editor.menu.search.page2", " of ");
		ds_map_add(global.langmap, "editor.menu.search.pagnext", "Next");
		ds_map_add(global.langmap, "editor.menu.search.pagprev", "Prev");
		ds_map_add(global.langmap, "editor.menu.search.search", "Search");
		ds_map_add(global.langmap, "editor.menu.search.upload", "Upload");
		ds_map_add(global.langmap, "editor.menu.level.author", "By ");
		ds_map_add(global.langmap, "editor.menu.level.play", "Play");
		ds_map_add(global.langmap, "editor.menu.level.download", "Download");
		ds_map_add(global.langmap, "editor.menu.level.downloaded", "Level Downloaded!");
		ds_map_add(global.langmap, "editor.menu.level.debug", "Details");
		ds_map_add(global.langmap, "editor.menu.level.debugmap", "CTRL C to copy full map");
		ds_map_add(global.langmap, "editor.menu.level.debugcopied", "Copied");
		ds_map_add(global.langmap, "editor.menu.login.password", "Password");
		ds_map_add(global.langmap, "editor.menu.login.reenter", "Re-enter Password");
		ds_map_add(global.langmap, "editor.menu.login.login", "Log In");
		ds_map_add(global.langmap, "editor.menu.login.register", "Register");
		ds_map_add(global.langmap, "editor.menu.login.dumbfuck", "Input a Password");
		ds_map_add(global.langmap, "editor.menu.login.dumbfuck2", "Passwords Don't Match!");
		ds_map_add(global.langmap, "editor.menu.login.success", "Logged In!");
		ds_map_add(global.langmap, "editor.menu.async.invalid", "Invalid Data");
		ds_map_add(global.langmap, "editor.menu.async.unexpected", "Got Unexpected Results");
		ds_map_add(global.langmap, "editor.menu.async.unauthorized", "Unauthorized");
		
		// messages
		ds_map_add(global.langmap, "msg.titleoption", "Options");
		ds_map_add(global.langmap, "msg.titlesel.0", "Start Game");
		ds_map_add(global.langmap, "msg.titlesel.1", "Options");
		ds_map_add(global.langmap, "msg.titlesel.2", "Quit");
		
		// level names
		ds_map_add(global.langmap, "msg.level.entrance", "Entrance");
		ds_map_add(global.langmap, "msg.level.medieval", "Pizzascape");
		ds_map_add(global.langmap, "msg.level.ruin", "The Ancient Cheese");
		ds_map_add(global.langmap, "msg.level.dungeon", "Bloodsauce Dungeon");
		ds_map_add(global.langmap, "msg.level.desert", "Oregano Desert");
		ds_map_add(global.langmap, "msg.level.graveyard", "The Wasteyard");
		ds_map_add(global.langmap, "msg.level.farm", "Fun Farm WIP");
		ds_map_add(global.langmap, "msg.level.ufo", "Space Pinball");
		ds_map_add(global.langmap, "msg.level.forest", "Gnome Forest WIP");
		ds_map_add(global.langmap, "msg.level.beach", "Pineapple Beach WIP");
		ds_map_add(global.langmap, "msg.level.kungfu", "Kung Fu");
		ds_map_add(global.langmap, "msg.level.minigolf", "Golf");
		ds_map_add(global.langmap, "msg.level.space", "Space");
		ds_map_add(global.langmap, "msg.level.city", "City");
		ds_map_add(global.langmap, "msg.level.sewer", "Sewers");
		ds_map_add(global.langmap, "msg.level.war", "War");
		ds_map_add(global.langmap, "msg.level.factory", "Factory");
		ds_map_add(global.langmap, "msg.level.mansion", "Mansion");
		ds_map_add(global.langmap, "msg.level.freezer", "Freezer");
		ds_map_add(global.langmap, "msg.level.kidsparty", "Kids Party");
		ds_map_add(global.langmap, "msg.level.dragonlair", "Dragon Lair");
		ds_map_add(global.langmap, "msg.level.chateau", "Pizzascare");
		ds_map_add(global.langmap, "msg.level.strongcold", "Strongcold");
		ds_map_add(global.langmap, "msg.level.exit", "Exit");
		
		ds_map_add(global.langmap, "msg.level.golf", "Golf");
		ds_map_add(global.langmap, "msg.level.snickchallenge", "Snick Challenge");
		ds_map_add(global.langmap, "msg.level.snickrematch", "Snick Rematch");
		ds_map_add(global.langmap, "msg.level.medieval_re", "Snick Castle");
		ds_map_add(global.langmap, "msg.level.ruin_re", "Ruins Of The Temple");
		ds_map_add(global.langmap, "msg.level.dungeon_re", "Bloodbath Dungeon");
		ds_map_add(global.langmap, "msg.level.etb", "Early Test Build");
		ds_map_add(global.langmap, "msg.level.ancient", "Ancient Tower WIP");
		ds_map_add(global.langmap, "msg.level.grinch", "Grinch");
		
		ds_map_add(global.langmap, "msg.level.cotton", "Cottontown WIP");
		ds_map_add(global.langmap, "msg.level.jawbreaker", "Jawbreaker Mines WIP");
		
		// roomname
		ds_map_add(global.langmap, "roomname.characterselect", "Mode Select");
		
		ds_map_add(global.langmap, "roomname.hub_room1", "Tower Floor 1");
		ds_map_add(global.langmap, "roomname.hub_room2", "Tower Floor 2");
		ds_map_add(global.langmap, "roomname.hub_roomE", "Other Levels");
		ds_map_add(global.langmap, "roomname.hub_roomE2", "Dresser");
		ds_map_add(global.langmap, "roomname.hub_roomE3", "Dance Room");
		ds_map_add(global.langmap, "roomname.hub_roomMOD", "Arcade");
		ds_map_add(global.langmap, "roomname.hub_roomSP", "Spire Floor 1");
		ds_map_add(global.langmap, "roomname.hub_roomPLN", "Nightmare Hub");
		
		ds_map_add(global.langmap, "roomname.hub_outside2", "Outside");
		ds_map_add(global.langmap, "roomname.hub_outside3", "Hub Of Fun");
		ds_map_add(global.langmap, "roomname.hub_outside3b", "Lounge");
		ds_map_add(global.langmap, "roomname.hub_outside3b2", "Battle Dungeon");
		ds_map_add(global.langmap, "roomname.hub_outside3c", "Gravitational Rails");
		ds_map_add(global.langmap, "roomname.hub_outside3d", "Suplex Museum");
		ds_map_add(global.langmap, "roomname.hub_outside3e", "Freerun");
		
		ds_map_add(global.langmap, "roomname.entryway_secret1", "Gumslime Paradise");
		ds_map_add(global.langmap, "roomname.entryway_secret2", "Wet Floor");
		ds_map_add(global.langmap, "roomname.entryway_secret3", "Fine China");
		ds_map_add(global.langmap, "roomname.entryway_1", "Operation Crunch Creak Construct");
		ds_map_add(global.langmap, "roomname.entryway_2", "Hard Hat Required");
		ds_map_add(global.langmap, "roomname.entryway_3", "Orange City");
		ds_map_add(global.langmap, "roomname.entryway_4", "Construction Conglomerate");
		ds_map_add(global.langmap, "roomname.entryway_5", "Had A Joke But I'm Still Working On It");
		ds_map_add(global.langmap, "roomname.entryway_6", "Down And Around");
		ds_map_add(global.langmap, "roomname.entryway_7", "Wires And Boxes");
		ds_map_add(global.langmap, "roomname.entryway_8", "City Outskirts");
		ds_map_add(global.langmap, "roomname.entryway_9", "Nailed It");
		ds_map_add(global.langmap, "roomname.entryway_10", "Beary Careful");
		
		ds_map_add(global.langmap, "roomname.cotton_secret1", "Rocky Road");
		ds_map_add(global.langmap, "roomname.cotton_secret2", "Kick Gum And Chew Gum");
		ds_map_add(global.langmap, "roomname.cotton_secret3", "Digging For Cotton");
		ds_map_add(global.langmap, "roomname.cotton_1", "Welcome to Cottontown!");
		ds_map_add(global.langmap, "roomname.cotton_2", "Scary Monsters Nice Sights");
		ds_map_add(global.langmap, "roomname.cotton_3", "Boiler Room");
		ds_map_add(global.langmap, "roomname.cotton_4", "Cakewalk");
		ds_map_add(global.langmap, "roomname.cotton_5", "Steamy Cotton Candy");
		ds_map_add(global.langmap, "roomname.cotton_6", "Skyhigh");
		ds_map_add(global.langmap, "roomname.cotton_7", "Grand Gateau");
		ds_map_add(global.langmap, "roomname.cotton_8", "A Clockwork Worm");
		ds_map_add(global.langmap, "roomname.cotton_9", "Clocks And Candies");
		ds_map_add(global.langmap, "roomname.cotton_10", "Race Around The Clock");
		ds_map_add(global.langmap, "roomname.cotton_11", "Froghop");
		ds_map_add(global.langmap, "roomname.cotton_12", "Pillars Break Room");
	}
	
	#endregion
	
	if ds_map_empty(global.langmap)
		show_message("Language \"" + string(lang) + "\" failed to load!!");
}