extends "res://src/enemies/nodes/base_enemy/base_enemy.gd"

onready var attackArea = $attackArea
onready var animation = $Animation

enum {
	ATTACK
}

func _ready():
	animation.play("run")
	stat_instance = stats_system.new(data)
	hitbox.damage = stat_instance.DAMAGE
	can_knockbacked = false

func _physics_process(delta):
	match state:
		ATTACK:
			state_attack()
		DEATH:
			animation.play("death")

func state_attack():
	Motion = Vector2()


func _on_attackArea_body_entered(body):
	state = ATTACK
	animation.play("attack")


func end_attack():
	state = CHASE

func _on_take_damge(area):
	end_take_damage()
	pass
#	animation.play("take_damage")

const data = {
	'MAX_HP': 400,
	'MAX_EXP': 30,
	'LVL': 1,
	'MOVE_SPEED': 100.0,
	'DASH_SPEED': 600.0,
	'CDR': 0.0,
	'ATTACK_SPEED': 3.0,
	'PROJECTILE_SPEED': 300.0,
	'CAST_DURATION': 100,
	'INCREASE_AREA': 0.0,
	'DAMAGE': 20.0,
	'DARK_AMPLIFY': 0,
	'WINDOW_AMPLIFY': 0,
	'LIGHTING_AMPLIFY': 0,
	'FIRE_AMPLIFY': 0,
	'DARK_RESIST': 0,
	'WINDOW_RESIST': 0,
	'LIGHTING_RESIST': 0,
	'FIRE_RESIST': 0,
}
