if obj_player1.character == "P" // peppino
{
	if global.rank == "s"
		sprite_index = spr_rankS
	if global.rank == "a"
		sprite_index = spr_rankA
	if global.rank == "b"
		sprite_index = spr_rankB
	if global.rank == "c"
		sprite_index = spr_rankC
	if global.rank == "d" or global.rank == "eggplant"
		sprite_index = spr_rankD
}
else if obj_player1.character == "SP" // pizzelle
{
	if global.rank == "s"
		sprite_index = spr_rankSPS
	if global.rank == "a"
		sprite_index = spr_rankSPA
	if global.rank == "b"
		sprite_index = spr_rankSPB
	if global.rank == "c"
		sprite_index = spr_rankSPC
	if global.rank == "d" or global.rank == "eggplant"
		sprite_index = spr_rankSPD
}
else if obj_player1.character == "PP" // pissino the greatest
{
	if global.rank == "s"
		sprite_index = spr_rankPPS
	if global.rank == "a"
		sprite_index = spr_rankPPA
	if global.rank == "b"
		sprite_index = spr_rankPPB
	if global.rank == "c"
		sprite_index = spr_rankPPC
	if global.rank == "d" or global.rank == "eggplant"
		sprite_index = spr_rankPPD
}
else // noise
{
	if global.rank == "s"
		sprite_index = spr_rankNS
	if global.rank == "a"
		sprite_index = spr_rankNA
	if global.rank == "b"
		sprite_index = spr_rankNB
	if global.rank == "c"
		sprite_index = spr_rankNC
	if global.rank == "d" or global.rank == "eggplant"
		sprite_index = spr_rankND
}
if global.rank == "yousuck"
	sprite_index = spr_yousuck

if floor(image_index) >= image_number - 1
	image_speed = 0;