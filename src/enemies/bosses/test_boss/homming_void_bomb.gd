extends Base_ability

var arrow = load("res://src/enemies/bosses/test_boss/void_bomb.tscn")

const RANDOM_ANGLE = PI / 2.0
var count = 12

func _on_homming_void_bomb_execute(spawn_position, damage):
	for i in count:
		var direction =  Vector2.UP.rotated(owner_body.ray_cast.rotation)
		var instance = arrow.instance()
		instance.load_info(owner_body, spawn_position, rand_range(owner_body.ray_cast.rotation - 2, owner_body.ray_cast.rotation + 2), damage_type, damage)
		get_node("/root").add_child(instance)
