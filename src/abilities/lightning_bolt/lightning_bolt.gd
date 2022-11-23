extends Base_ability

var ligtning_projectile = load("res://src/attacks/projectiles/lightning_bolt/lightning_bolt.tscn")

func execute(s: Base_body, spawn_position):
	var instance = ligtning_projectile.instance()
	get_node("/root").add_child(instance)
	instance.load_info(s, spawn_position, s.ray_cast.rotation)
