if !global.pastdisclaimer && !debug
{
	room_goto(room_of_dog);
	exit;
}
scr_getinput();

basegrav = 0.5;
grav = basegrav;

gravmult = 1;
hsp = 0;
vsp = 0;
xscale = 1;
yscale = 1;
facehurt = false
steppy = false
depth = -7
movespeed = 0
jumpstop = false

visible = true
state = states.normal
if room == Realtitlescreen
	state = states.titlescreen

jumpAnim = true
landAnim = false
machslideAnim = false
moveAnim = true
stopAnim = true
crouchslideAnim = true
crouchAnim = true
machhitAnim = false
stompAnim = false

inv_frames = false

hurted = false
autodash = false
mach2 = 0

parry = false
parry_inst = noone
taunt_to_parry_max = 10
parry_count = 0
parry_max = 8

input_buffer_jump = 8
input_buffer_secondjump = 8
input_buffer_highjump = 8
player_x = x
player_y = y
targetRoom = 0
targetDoor = "A"

flash = false

key_particles = false
barrel = false
bounce = false
a = 0
idle = 0
attacking = false
slamming = false
superslam = 0
grounded = true
grinding = false

machpunchAnim = false
punch = false
machfreefall = 0
shoot = true
instakillmove = false
windingAnim = 0
facestompAnim = false
ladderbuffer = 0
toomuchalarm1 = 0
toomuchalarm2 = 0

idleanim = 0
momentum = false
cutscene = false
grabbing = false
dir = xscale
shotgunAnim = false

goingdownslope = false
goingupslope = false
fallinganimation = 0
bombpeptimer = 100

suplexmove = false
suplexhavetomash = 0

anger = 0
angry = false
baddiegrabbedID = 0
spr_palette = spr_peppalette
character = "P"

scr_characterspr()
paletteselect = check_shaders()
sprite_index = spr_idle

colorchange = false

palcolors = ds_list_create();
dsread = "";
palsurf = -1;

//Second lap
treasure_x = 0
treasure_y = 0
treasure_room = 0

wallspeed = 0

tauntstoredstate = states.normal
tauntstoredmovespeed = 6
tauntstoredsprite = spr_idle
taunttimer = 0

backtohubstartx = 0
backtohubstarty = 0
backtohubroom = hub_room1

slapcharge = 0
slaphand = 1
slapbuffer = 8
slapflash = 0

freefallsmash = 0
costumercutscenetimer = 0

heavy = false

lastroom_x = 0
lastroom_y = 0
lastroom = 0

hallway = false
hallwaydirection = 0
box = false
oldhallway = false

roomstartx = 0
roomstarty = 0

swingdingbuffer = 0
lastmove = 0
backupweapon = false

stickpressed = false

spotlight = true
macheffect = false
chargeeffectid = obj_null
dashcloudid = obj_null

crazyruneffectid = obj_null
fightball = false
superslameffectid = obj_null
speedlineseffectid = obj_null
angryeffectid = obj_null
thrown = false

candyeffect = noone

mach1snd = -1
mach2snd = -1
mach3snd = -1
knightslide = -1
bombpep1snd = -1
mach4snd = -1
tumble2snd = -1
tumble1snd = -1
tumble3snd = -1
superjumpholdsnd = -1
superjumpprepsnd = -1
suplexdashsnd = -1
flipsnd = -1

pogospeed = 2
pogocharge = 100
pogochargeactive = false
wallclingcooldown = 10

bombcharge = 0

flashflicker = false
flashflickertime = 0
kickbomb = false
doublejump = false

pogospeedprev = false
 fightballadvantage = false
coopdelay = 0

supercharge = 0
supercharged = false
superchargedeffectid = obj_null

pizzashield = false
pizzashieldid = obj_null

pizzapepper = 0

transformation = [
	states.bombpep,
	states.knightpep,
	states.knightpepslopes,
	states.boxxedpep,
	states.cheeseball,
	states.cheesepep,
	states.cheesepepstick,
	states.firemouth,
	states.fireass,
	states.tumble,
	states.stunned,
	states.rideweenie,
	states.gameover,
	states.door,
	states.ghost,
	states.mort,
	states.hitlag,
	states.knightpepattack,
	states.tube,
	states.rocket,
	states.rocket,
	
	states.cotton,
]

c = 0
revolverbuffer = 0
breakdance = 50;

hooked = false;
sprgot = -1;
nickname = "";
noisetype = (global.gameplay == 0 ? 0 : 1);
noisebombcooldown = 0;
springsjump = false;
keydoor = false;
storedstate = states.normal;
grabbedby = -1;
shake = 0;
drawspr = sprite_index;
online_busy = false;
sjump = true;

// hat
hatsprite = -1;
hatimg = 0;

// pet
petfollow = -1;

// new shit
skateboarding = false;

hurt_buffer = -1;
hurt_max = 120;
invhurt_buffer = 0;
invhurt_max = 30;

shot = false;
shoot_buffer = 0;
shoot_max = 20;

mort = false;
sjumpvsp = -12;
freefallvsp = 15;

hitX = x;
hitY = y;
hithsp = 0;
hitvsp = 0;
hitstunned = false;
hitxscale = 1;
stunned = false;
hitLag = 25;

doorx = x;

verticalhallway = false;
vhallwaydirection = 0;
vhallwaypos = 0;

endtumble = false
hascollision = true

img_angle = 0
canfall = true
godmode = false

konami = "";
konamiend = "UUDDLRLRBA";

input_buffer_faceplant = 8;

// globals
if !variable_global_exists("saveroom")
{
	global.saveroom = ds_list_create();
	global.baddieroom = ds_list_create();
	global.followerlist = ds_list_create();
	global.baddietomb = ds_list_create();
	
	global.playerhealth = 100
	
	global.toppintotal = 1
	global.shroomfollow = false
	global.cheesefollow = false
	global.tomatofollow = false
	global.sausagefollow = false
	global.pineapplefollow = false

	global.key_inv = 0
	global.keyget = false
	global.giantkey = false
	global.collect = 0
	global.collectN = 0
	global.treasure = false
	global.gotshotgun = false

	global.combo = 0
	global.combotime = 0
	global.hit = 0

	global.panic = false
	global.snickchallenge = false
	global.snickrematch = false

	global.golfhit = 0
	global.funmode = false
	global.secretfound = 0

	scr_setcoin(0)
	global.pizzacoinstart = global.pizzacoin;

	global.heattime = 0;
	global.style = 0;
	global.stylethreshold = 0;
	global.baddiespeed = 1;
	global.baddiepowerup = false;
	global.baddierage = false;

	global.showgnomelist = true;
	global.pizzadelivery = false;
	global.failcutscene = false;
	global.pizzasdelivered = 0;

	global.spaceblockswitch = true;

	global.bullet = 3;
	global.mort = false;

	global.gerome = false;
	global.stylelock = false;
}

