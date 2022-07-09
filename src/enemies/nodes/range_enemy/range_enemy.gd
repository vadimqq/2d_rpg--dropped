extends "res://src/enemies/nodes/base_enemy/base_enemy.gd"

onready var muzzle = $Muzzle

signal on_player()

enum {
	ATTACK
}
var player_in_attack_radius = false

func _physics_process(delta):
	muzzle.look_at(player.global_position)
	match state:
		ATTACK:
			state_attack()

func state_attack():
	Motion = Vector2()


func _on_PlayerDetectionZone_body_exited(body):
	state = CHASE
