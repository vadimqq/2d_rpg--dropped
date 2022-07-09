extends "res://src/enemies/nodes/range_enemy/range_enemy.gd"

onready var animation = $Animation
onready var attack_pivot = $Muzzle/AttackPivot

var projectile = preload("res://src/enemies/skull/attack/attack.tscn")

func _ready():
	create_stat_instance_by_portal_lvl(data)

	animation.play("fly")
	hitbox.damage = stat_instance.DAMAGE
	animation.playback_speed = stat_instance.ATTACK_SPEED

func _physics_process(delta):
	match state:
		DEATH:
			death()

func attack():
		var projectile_instance = projectile.instance()
		attack_pivot.add_child(projectile_instance)
		projectile_instance.fire(attack_pivot.global_transform, muzzle.rotation, stat_instance.DAMAGE, stat_instance.PROJECTILE_SPEED)

func _on_take_damage(area):
		animation.play("take_damage")


const data = {
	'MAX_HP': 50,
	'MAX_EXP': 30,
	'LVL': 1,
	'MOVE_SPEED': 100.0,
	'DASH_SPEED': 600.0,
	'CDR': 0.0,
	'ATTACK_SPEED': 0.5,
	'PROJECTILE_SPEED': 200.0,
	'CAST_DURATION': 100,
	'INCREASE_AREA': 0.0,
	'DAMAGE': 10.0,
	'DARK_AMPLIFY': 0,
	'WINDOW_AMPLIFY': 0,
	'LIGHTING_AMPLIFY': 0,
	'FIRE_AMPLIFY': 0,
	'DARK_RESIST': 0,
	'WINDOW_RESIST': 0,
	'LIGHTING_RESIST': 0,
	'FIRE_RESIST': 0,
}


func _on_can_player_attack(body):
	animation.play("attack")


func _on_state_chase(body):
	animation.play("fly")
