dialogue = [
	"Thanks for bringing the pizza, Peppino.",
	"Sadly I'm the only one who came...",
	"You can still try out the games.",
	"But before starting,^1 I suggest going down to the left\nto learn some important moves."
]
with obj_player
{
	if hatsprite > -1
	{
		other.dialogue = [
			"You did it!",
			"Yes, you the player!",
			"You did all of this demo's content.",
			"There's nothing left to do!",
			"Get yourself a pizza or something.",
			//"Go play the real other SAGE games.",
			"Oh, and you can go home, Peppino.",
			"Bring the hat."
		]
		exit;
	}
}

// dialogue depending on progression
ini_open("saveData" + string(global.saveslot) + ".ini");
var medievalrank = ini_read_string("Ranks", "medieval", "none");
var ruinrank = ini_read_string("Ranks", "ruin", "none");
var dungeonrank = ini_read_string("Ranks", "dungeon", "none");
var snickchallengerank = ini_read_string("Ranks", "snickchallenge", "none");
ini_close();

if snickchallengerank != "none"
{
	dialogue = [
		"Well, congrats, you beat my challenge.",
		"You can play as me now.",
		"Go to the dresser room,^1 and select me in the skin menu.",
	]
}
else if medievalrank != "none" && ruinrank != "none" && dungeonrank != "none"
{
	sprite_index = spr_snick_exe;
	dialogue = [
		"You shouldn't have played the games.",
		"You will suffer the consequences...",
		"Accept my challenge if you dare."
	]
}
else if medievalrank == "s" or ruinrank == "s" or dungeonrank == "s"
{
	dialogue = [
		"Wow, you got an S rank.",
		"Keep it up!"
	]
}
else if medievalrank == "d" or ruinrank == "d" or dungeonrank == "d"
{
	dialogue = [
		"Wow, you're pretty bad at these games.",
		"It's ok, they aren't that great either."
	]
}
else if medievalrank != "none" or ruinrank != "none" or dungeonrank != "none"
{
	dialogue = [
		"Try beating all of the levels!",
		"Keep it up!"
	]
}

// destroy snick challenge pc
if medievalrank == "none" or ruinrank == "none" or dungeonrank == "none"
	instance_destroy(inst_4B888DF3);

