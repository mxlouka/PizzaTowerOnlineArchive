if place_meeting(x, y, obj_player) && alarm[0] == -1
    gonnajump = true;
if !place_meeting(x, y, obj_player) && gonnajump && alarm[0] == -1
    alarm[0] = 6;

if alarm[0] != -1
    y -= 4;

