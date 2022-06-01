if grounded
{
    with obj_camera
    {
        shake_mag = 3
        shake_mag_acc = 3 / room_speed
    }
	repeat 3
		instance_create(x, y, obj_slapstar)
    with instance_create(x, y, obj_sausageman_dead)
    {
        sprite_index = other.sprite_index
        image_speed = 0
        image_index = other.image_index
		image_angle = irandom(360)
    }
    instance_destroy()
}
scr_collide()

