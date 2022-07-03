extends Node2D

var lightning_bolt = preload("res://src/skills/lightning/lightning_bolt/lightning_bolt.tscn")
var lightning_discharge = preload("res://src/skills/lightning/lightning_discharge/lightning_discharge.tscn")

onready var animation = $Animation
onready var muzzle = $Muzzle
onready var lightning_discharge_timer = $Lightning_discharge_timer

var stats_instance = null

var can_cast_ligtning_chain = false
var ligtning_chain_damage = 0

func _ready():
	animation.play("idle")
	stats_instance = get_tree().get_nodes_in_group('player')[0].stats_instance

func _process(delta):
	muzzle.look_at(get_global_mouse_position())

func cast_spell(stats):
	stats_instance = stats
	var lightning_bolt_instance = lightning_bolt.instance()
	lightning_bolt_instance.flip_v = global_transform.x.x < 0
	lightning_bolt_instance.can_cast_ligtning_chain = can_cast_ligtning_chain
	lightning_bolt_instance.ligtning_chain_damage = ligtning_chain_damage
	add_child(lightning_bolt_instance)
	lightning_bolt_instance.fire(global_transform, muzzle.rotation, stats.DAMAGE, stats.PROJECTILE_SPEED)

func cast_lightning_discharge():
	randomize()
	var lightning_discharge_instance = lightning_discharge.instance()
	var rand_x = rand_range(global_position.x - 500, global_position.x + 500)
	var rand_y = rand_range(global_position.y - 400, global_position.y + 400)
	
	lightning_discharge_instance.damage = stats_instance.DAMAGE
	lightning_discharge_instance.global_position = Vector2(rand_x, rand_y)
	add_child(lightning_discharge_instance)
	lightning_discharge_timer.start()


func up_lighting_speed():
	var upgrade_lvl = upgrade_dictionary['lightning_speed']['lvl']
	var upgrade_value = (stats_instance.BASE_ATTACK_SPEED /100) * upgrade_dictionary['lightning_speed']['upgrades'][upgrade_lvl]['value']
	
	upgrade_dictionary['lightning_speed']['lvl'] += 1
	stats_instance.up_attack_speed(upgrade_value)

func up_lightning_discharge():
	var upgrade_lvl = upgrade_dictionary['lightning_discharge']['lvl']
	var cd_time = upgrade_dictionary['lightning_discharge']['upgrades'][upgrade_lvl]['value']
	
	upgrade_dictionary['lightning_discharge']['lvl'] += 1
	lightning_discharge_timer.wait_time = cd_time
	lightning_discharge_timer.start()
	

func up_lightning_chain():
	can_cast_ligtning_chain = true
	var upgrade_lvl = upgrade_dictionary['lightning_chain']['lvl']
	var upgrade_value = (stats_instance.DAMAGE /100) * upgrade_dictionary['lightning_chain']['upgrades'][upgrade_lvl]['value']
	ligtning_chain_damage += upgrade_value
	
	upgrade_dictionary['lightning_chain']['lvl'] += 1

var upgrade_dictionary = {
	'lightning_speed': {
		'name': 'lightning speed',
		'lvl': 1,
		'updete_func': funcref(self, "up_lighting_speed"),
		'upgrades': {
			1: {
				'discription': 'base attack speed + 10%',
				'value': 10
			},
			2: {
				'discription': 'base attack speed + 10%',
				'value': 10
			}
		}
	},
	'lightning_chain': {
		'name': 'lightning chain',
		'lvl': 1,
		'updete_func': funcref(self, "up_lightning_chain"),
		'upgrades': {
			1: {
				'discription': 'add lightning chain on sprit base attack',
				'value': 10
			},
			2: {
				'discription': 'lightning chain damage + 10%',
				'value': 10
			}
		}
	},
	'lightning_discharge': {
		'name': 'lightning discharge',
		'lvl': 1,
		'updete_func': funcref(self, "up_lightning_discharge"),
		'upgrades': {
			1: {
				'discription': 'add new spell on spirit',
				'value': 2.0
			},
			2: {
				'discription': 'cd - 10%',
				'value': 1.0
			}
		}
	}
}


func _on_Lightning_discharge_timer_timeout():
	cast_lightning_discharge()
