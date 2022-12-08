/// @description turn on rich presence
running = true;

instance_destroy(nekoPresence);
instance_create(0, 0, nekoPresence);
