image_speed = 0.35
depth = 104

targetDoor = "A"

if obj_player1.character == "N"
	sprite_index = spr_boxofpizzaN
if check_sugary()
{
	sprite_index = spr_boxofpizzaSP
	mask_index = sprite_index
}

if string_startswith(room_get_name(room), "strongcold")
	sprite_index = spr_xmaspizzaboxdown
if global.snickrematch
	sprite_index = spr_boxofpizza_re
