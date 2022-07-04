extends Node2D

var dark_ball = preload("res://src/skills/dark/dark_ball/dark_ball.tscn")
var void_helix = preload("res://src/skills/dark/dark_helix/dark_helix.tscn")

onready var muzzle = $Muzzle
onready var animation = $Animation
onready var spawn_attack_position = $Muzzle/Position2D
onready var void_helix_timer = $VoidHelixTimer

var stats_instance = null

var void_helix_balancer = 4
var void_helex_speed = 5.0
var void_helex_orb_count = 5
var void_helex_cast_duration = 10

func _ready():
	animation.play("idle")

func _process(delta):
	muzzle.look_at(get_global_mouse_position())

func cast_spell(stats):
	stats_instance = stats
	var dark_ball_instance = dark_ball.instance()
	dark_ball_instance.flip_v = global_position.x > get_global_mouse_position().x
	add_child(dark_ball_instance)
	dark_ball_instance.fire(spawn_attack_position.global_transform, muzzle.rotation, get_damage_after_amplify(), stats.PROJECTILE_SPEED)

func cast_void_helix():
	var void_helix_instance = void_helix.instance()
	void_helix_instance.damage = get_damage_after_amplify() / void_helix_balancer
	void_helix_instance.speed = void_helex_speed
	void_helix_instance.max_orb_count = void_helex_orb_count
	void_helix_instance.life_time = void_helex_cast_duration + ((void_helex_cast_duration / 100) * stats_instance.CAST_DURATION)
	add_child(void_helix_instance)
	void_helix_timer.start()

func up_dark_damage():
	var upgrade_lvl = upgrade_dictionary['dark_damage']['lvl']
	var upgrade_value = (stats_instance.BASE_DAMAGE /100) * upgrade_dictionary['dark_damage']['upgrades'][upgrade_lvl]['value']

	upgrade_dictionary['dark_damage']['lvl'] += 1
	stats_instance.up_damage(upgrade_value)

func up_void_helix():
	var upgrade_lvl = upgrade_dictionary['void_helix']['lvl']
	var cd_time = upgrade_dictionary['void_helix']['upgrades'][upgrade_lvl]['cd']
	
	void_helix_timer.wait_time = cd_time
	void_helex_speed = upgrade_dictionary['void_helix']['upgrades'][upgrade_lvl]['projectile_speed']
	void_helex_orb_count = upgrade_dictionary['void_helix']['upgrades'][upgrade_lvl]['projectile_count']
	
	cast_void_helix()
	upgrade_dictionary['void_helix']['lvl'] += 1

func up_dark_amplify():
	var upgrade_lvl = upgrade_dictionary['dark_amplify']['lvl']
	stats_instance.up_dark_amplify(upgrade_dictionary['dark_amplify']['upgrades'][upgrade_lvl]['value'])
	
	upgrade_dictionary['dark_amplify']['lvl'] += 1


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
	},
	'void_helix': {
		'name': 'void helix',
		'lvl': 1,
		'updete_func': funcref(self, "up_void_helix"),
		'image_src': 'res://src/spirits/dark_spirit/dark_spirit.png',
		'upgrades': {
			1: {
				'discription': 'add new spell on spirit',
				'cd': 30,
				'projectile_count': 6,
				'projectile_speed': 5.0
			},
			2: {
				'discription': 'base damage + 10%',
				'cd': 25,
				'projectile_count': 10,
				'projectile_speed': 5.0
			}
		}
	},
		'dark_amplify': {
		'name': 'Dark damage amplify ',
		'lvl': 1,
		'updete_func': funcref(self, "up_dark_amplify"),
		'image_src': 'res://src/spirits/dark_spirit/dark_spirit.png',
		'upgrades': {
			1: {
				'discription': 'more damage by dark spells + 10%',
				'value': 10,
			},
			2: {
				'discription': 'more damage by dark spells + 10%',
				'value': 10,
			}
		}
	}
}

func get_damage_after_amplify():
	return stats_instance.DAMAGE + (stats_instance.DAMAGE /100) * stats_instance.DARK_AMPLIFY


func _on_VoidHelixTimer_timeout():
	cast_void_helix()
