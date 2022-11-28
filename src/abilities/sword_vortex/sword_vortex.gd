extends Base_ability

var sword = load("res://src/attacks/projectiles/sword/sword.tscn")
var rotated_node = load("res://src/entities/rotate_node/rotate_node.tscn")

onready var tick_timer = $tick
var is_active = false

var count = 1
var rotate_speed = 100
var radius = 20
var node = null

func _init():
	price = 10
	tier = 3
	type = CONSTANTS.ABILITY_TYPE_ENUM.MAINTAIN
	tags = [CONSTANTS.WEAPON_TYPES.SWORD]
	CD = 5.0
	max_lvl = 3
	mana_cost = 2
	damage_incounter = 0.4

func execute(s: Base_body, spawn_position):
	owner_body = s
	if !is_active:
		node = rotated_node.instance()
		node.rotate_speed = rotate_speed * s.STATS.get_attack_speed()
		node.radius = radius
		for i in count:
			var direction =  Vector2.UP.rotated(s.ray_cast.rotation)
			var instance = sword.instance()
			instance.load_info(s, transform, s.ray_cast.rotation, damage_tags, s.STATS.get_physic_damage() * damage_incounter)
			instance.speed = 0
			node.add_child(instance)
		
		GAME_CORE.player.add_child(node)
		tick_timer.start()
		is_active = true
	else:
		disable()
	start_cd()

func maintain():
	if owner_body.STATS.CURRENT_MANA  < mana_cost:
		disable()
	else:
		owner_body.STATS.modify_current_mana(-mana_cost)

func disable():
	GAME_CORE.player.remove_child(node)
	node = null
	tick_timer.stop()
	is_active = false
func _on_sword_vortex_upgrade(s: Base_body, new_lvl):
	match new_lvl:
		1:
			count = 2
			mana_cost = 7
			price = 20
		2:
			count = 3
			mana_cost = 9
			price = 30
		3:
			count = 4
			mana_cost = 10
			price = 40
	lvl = new_lvl



func _on_tick_timeout():
	maintain()
