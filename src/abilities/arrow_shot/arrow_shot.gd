extends Base_ability

var arrow = load("res://src/attacks/projectiles/arrow/arrow.tscn")

func _init():
	tags = [CONSTANTS.WEAPON_TYPES.BOW]

func execute(s: Base_body, spawn_position):
	var instance = arrow.instance()
	instance.load_info(s, spawn_position, s.ray_cast.rotation)
	get_node("/root").add_child(instance)

func _on_arrow_shot_upgrade(new_lvl):
	match new_lvl:
		1:
			pass
	lvl = new_lvl
