extends Node2D

var dark_ball = preload("res://src/skills/dark/dark_ball/dark_ball.tscn")

onready var muzzle = $Muzzle
onready var animation = $Animation

var stats_instance = null

func _ready():
	animation.play("idle")

func _process(delta):
	muzzle.look_at(get_global_mouse_position())

func cast_spell(stats):
	stats_instance = stats
	var dark_ball_instance = dark_ball.instance()
	dark_ball_instance.flip_v = global_position.x > get_global_mouse_position().x
	add_child(dark_ball_instance)
	dark_ball_instance.fire(global_transform, muzzle.rotation, stats.DAMAGE, stats.PROJECTILE_SPEED)

func up_dark_damage():
	var upgrade_lvl = upgrade_dictionary['dark_damage']['lvl']
	var upgrade_value = (stats_instance.BASE_DAMAGE /100) * upgrade_dictionary['dark_damage']['upgrades'][upgrade_lvl]['value']

	upgrade_dictionary['dark_damage']['lvl'] += 1
	stats_instance.up_damge(upgrade_value)

var upgrade_dictionary = {
	'dark_damage': {
		'name': 'void power',
		'lvl': 1,
		'updete_func': funcref(self, "up_dark_damage"),
		'image_src': 'res://src/spirits/dark_spirit/dark_spirit.png',
		'upgrades': {
			1: {
				'discription': 'base damage + 10%',
				'value': 10
			},
			2: {
				'discription': 'base damage + 10%',
				'value': 10
			}
		}
	}
}
