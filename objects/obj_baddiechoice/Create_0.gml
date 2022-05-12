event_inherited();

selarray = [
	[obj_pizzaboy, "PIZZA BOY", "Cardboard."],
	[obj_cheeseslime, "CHEESESLIME", "Totally useless. Cannon fodder."],
	[obj_forknight, "FORKNIGHT", "His variant is Battle Royale."],
	[obj_swedishmonkey, "SWEDISH MONKEY", "Desperate to get a laugh."],
	[obj_pizzard, "PIZZARD", "The pizzard circle studies pizzamancy."],
	[obj_ancho, "WINGED ANCHOVY", "Missed their glasses at home."],
	[obj_pizzagoblin, "PIZZABOX GOBLIN", "Urban legends tell of goblins that would\nhide in a pizza box and put bombs inside them."],
	[obj_minijohn, "MINI JOHN", "How exactly did these come to be?"],
	[obj_pepgoblin, "PEPPERONI GOBLIN", "He will take any opportunity to practice kicks."],
	[obj_treasureguy, "TREASURE GUY", "I wouldn't call it a treasure."],
	[obj_piraneapple, "PIRANEAPPLE", "Now with gravity!"],
	[obj_banditochicken, "BANDITO CHICKEN", "Boner explosion"],
	[obj_pizzice, "PIZZICE", "Rest in peace."],
	[obj_robot, "PEPPINO ROBOT", "How did they have the time to build these?"],
	[obj_kentukykenny, "KENTUCKY KENNY", "Might throw spicy chicken wings at you."],
	[obj_noisegoblin, "NOISE GOBLIN", "Spin."],
	[obj_canongoblin, "CANNON GOBLIN", "Fun fact this one is misspelled internally as \"canongoblin\"."],
	[obj_pickle, "PICKLE", "Pepinillo."],
	[obj_rancher, "RANCH SHOOTER", "Doesn't really shoot ranch though."],
	[obj_bigcheese, "BIG CHEESE", "Born with it's hard hat, eventually learned to get scared."],
	[obj_pizzaball, "GREASEBALL", "Everything in this game has to be cheese.\nEven a golf ball."],
	[obj_pizzaballOLD, "OLD GREASEBALL", "You see, instead of actually using them as a golf ball,\nyou beat the shit out of them."],
	[obj_spitcheese, "SPIT CHEESE", "Makes sense."],
	[obj_trash, "TRASH PAN", "Someone has a lot of spare cheese."],
	[obj_peasanto, "PEASANTO", "Arson!"],
	[obj_ninja, "NINJA SLICE", "A pizza slice with their fulfilled dreams of becoming a ninja."],
	[obj_coolpineapple, "COOL PINEAPPLE", "Where's the cool in getting parried?"],
	[obj_noisey, "NOISEY", "Fortunately not as noisey."],
	[obj_miniufo, "UFOLIVE", "Morty\nRick and M\norty"],
	[obj_miniufo_grounded, "GROUNDED UFOLIVE", "No need for a spaceship when you have a death wish."],
	[obj_indiancheese, "INDIAN CHEESE", "I shit you not, this cheese right here comes straight from the indian lands."],
	[obj_fencer, "PENCER", "Pizza fencer."],
	[obj_sausageman, "SAUSAGE MAN", "Don't do drugs."],
	["special1", "SMOKED SAUSAGE MAN", "He did drugs."],
	[obj_weeniesquire, "WEENIE SQUIRE", "HOG RIDER"],
	[obj_thug_red, "SHRIMP THUG", "Stereotypical street criminal, for the chinese themed level."],
	["bluethug", "BLUE THUG", "On a mission to stab an italian man with a flying knife."],
	["greenthug", "GREEN THUG", "I dare you to find it if you can."],
	[obj_soldier, "PIZZA SOLDIER", "He's camping."],
]
if global.gameplay != 0
{
	for(var i = array_length(selarray) - 1; i > 0; i--)
	{
		if selarray[i][0] == "greenthug"
			array_delete(selarray, i, 1);
		if selarray[i][0] == "bluethug"
			array_delete(selarray, i, 1);
	}
}
if sugaryspire
{
	array_push(selarray,
		[obj_coneboy, "CONEBOY", "Cardboard, now with a grain of sa-... sugar."],
		[obj_gumslime, "GUMSLIME", "Yeah, just um... replace the cheese with gum. Good enough. New enemy."],
		[obj_smurfknight, "SMOREKNIGHT", "You would not want to suffer the same fate that this Forknight had to."],
		[obj_charcherry, "CHAR CHERRY", "Cherry?! That's a walking fucking bomb!"],
		[obj_cottonwitch, "COTTON WITCH", "Not only is it a food swap but a gender swap as well."]
	);
}

spr_idle = -1;

sel[0] = 0;
selvert = false;

baddiemenu = noone;

event_user(0);