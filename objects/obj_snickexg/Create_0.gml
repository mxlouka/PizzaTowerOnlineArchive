event_inherited();

maxspeed = 1
quillt = 0

if global.snickchallenge && global.snickrematch && global.gameplay == 0
{
    with obj_tv
    {
        showtext = true
        message = "SNECK IS COMING"
        alarm[2] = 100
    }
}

