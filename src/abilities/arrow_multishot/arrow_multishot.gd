extends Base_ability

var arrow = load("res://src/attacks/projectiles/arrow/arrow.tscn")

const RANDOM_ANGLE = PI / 2.0
var count = 12

func _init():
	price = 10
	tags = [CONSTANTS.WEAPON_TYPES.BOW]
	CD = 5.0
	max_lvl = 3
	mana_cost = 10

func execute(s: Base_body, spawn_position):
	owner_body = s
	for i in count:
		var direction =  Vector2.UP.rotated(s.ray_cast.rotation)
		var instance = arrow.instance()
		instance.load_info(s, spawn_position, rand_range(s.ray_cast.rotation - 0.5, s.ray_cast.rotation + 0.5))
		get_node("/root").add_child(instance)
	start_cd()
	s.STATS.modify_mana(-mana_cost)

func _on_arrow_multishot_upgrade(s: Base_body, new_lvl):
	match new_lvl:
		1:
			count = 12
			mana_cost = 7
			price = 20
		2:
			count = 15
			mana_cost = 9
			price = 30
		3:
			count = 20
			mana_cost = 10
			price = 40
	lvl = new_lvl