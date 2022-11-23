extends Base_ability

var melee_slash = load("res://src/attacks/melee/melee_slash/melee_slash.tscn")

func init():
	tags = [CONSTANTS.WEAPON_TYPES.SWORD]

func execute(s: Base_body, spawn_position):
	var instance = melee_slash.instance()
	get_node("/root").add_child(instance)
	instance.load_info(s, spawn_position, s.ray_cast.rotation)
