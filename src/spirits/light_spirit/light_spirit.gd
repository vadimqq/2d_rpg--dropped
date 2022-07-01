extends Node2D

var light_bolt = preload("res://src/skills/light/light_bolt/light_bolt.tscn")
onready var animation = $Animation
onready var muzzle = $Muzzle

var stats_instance = null

func _ready():
	animation.play("idle")

func _process(delta):
	muzzle.look_at(get_global_mouse_position())

func cast_spell(stats):
	stats_instance = stats
	var light_bolt_instance = light_bolt.instance()
	light_bolt_instance.flip_v = global_transform.x.x < 0
	add_child(light_bolt_instance)
	light_bolt_instance.fire(global_transform, muzzle.rotation, stats.DAMAGE, stats.PROJECTILE_SPEED)

func up_lighting_speed(lvl):
	var upgrade_lvl = upgrade_dictionary['lighting_speed']['lvl']
	var upgrade_value = (stats_instance.BASE_ATTACK_SPEED /100) * upgrade_dictionary['lighting_speed']['upgrades'][upgrade_lvl]['value']
	upgrade_dictionary['lighting_speed']['lvl'] += 1
	print(upgrade_value)
	stats_instance.up_attack_speed(upgrade_value)

func up_lighting_damage(lvl):
	var upgrade_lvl = upgrade_dictionary['lighting_damage']['lvl']
	var upgrade_value = (stats_instance.BASE_DAMAGE /100) * upgrade_dictionary['lighting_damage']['upgrades'][upgrade_lvl]['value']
	upgrade_dictionary['lighting_damage']['lvl'] += 1
	print(upgrade_value)
	stats_instance.up_damge(upgrade_value)

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
				'value': 1000
			}
		}
	},
#	'lighting_damage': {
#		'name': 'lighting damage',
#		'lvl': 1,
#		'updete_func': funcref(self, "up_lighting_speed"),
#		'upgrades': {
#			1: {
#				'discription': 'base attack speed + 10%',
#				'value': 100
#			},
#			2: {
#				'discription': 'base attack speed + 10%',
#				'value': 200
#			}
#		}
#	}
}
