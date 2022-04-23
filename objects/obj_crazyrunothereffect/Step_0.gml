if global.gameplay != 0
	exit;

image_xscale = playerid.xscale

if playerid.movespeed <= 12 && playerid.state != states.faceplant && playerid.state != states.chainsawbump
	instance_destroy()

