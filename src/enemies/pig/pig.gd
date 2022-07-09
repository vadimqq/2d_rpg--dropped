extends "res://src/enemies/nodes/base_enemy/base_enemy.gd"

onready var animation = $Animation

func _ready():
	create_stat_instance_by_portal_lvl(data)
	
	animation.play("run")
	hitbox.damage = stat_instance.DAMAGE

func _physics_process(delta):
	match state:
		DEATH:
			death()

func _take_damage(area):
	animation.play("take_damage")

const data = {
		'MAX_HP': 50,
		'LVL': 1,
		'MOVE_SPEED': 100.0,
		'DASH_SPEED': 600.0,
		'CDR': 0.0,
		'ATTACK_SPEED': 3.0,
		'PROJECTILE_SPEED': 300.0,
		'CAST_DURATION': 100,
		'INCREASE_AREA': 0.0,
		'DAMAGE': 1.0,
		'DARK_AMPLIFY': 0,
		'WINDOW_AMPLIFY': 0,
		'LIGHTING_AMPLIFY': 0,
		'FIRE_AMPLIFY': 0,
		'DARK_RESIST': 0,
		'WINDOW_RESIST': 0,
		'LIGHTING_RESIST': 0,
		'FIRE_RESIST': 0,
	}
