extends Node2D

var dark_ball = preload("res://src/skills/dark/dark_ball/dark_ball.tscn")
onready var muzzle = $Muzzle
var stats_instance = null
func _process(delta):
	muzzle.look_at(get_global_mouse_position())

func cast_spell(stats):
	stats_instance = stats
	var dark_ball_instance = dark_ball.instance()
	dark_ball_instance.flip_v = global_transform.x.x < 0
	add_child(dark_ball_instance)
	dark_ball_instance.fire(global_transform, muzzle.rotation, stats.DAMAGE, stats.PROJECTILE_SPEED)

func up_lighting_speed(lvl):
	var upgrade_lvl = upgrade_dictionary['lighting_speed']['lvl']
	var upgrade_value = (stats_instance.BASE_ATTACK_SPEED /100) * upgrade_dictionary['lighting_speed']['upgrades'][upgrade_lvl]['value']
	upgrade_dictionary['lighting_speed']['lvl'] += 1
	print(upgrade_value)
	stats_instance.up_attack_speed(upgrade_value)

var upgrade_dictionary = {
	'lighting_speed': {
		'name': 'lighting speed',
		'lvl': 1,
		'updete_func': funcref(self, "up_lighting_speed"),
		'upgrades': {
			1: {
				'discription': 'base attack speed + 10%',
				'value': 100
			},
			2: {
				'discription': 'base attack speed + 10%',
				'value': 200
			}
		}
	}
}
