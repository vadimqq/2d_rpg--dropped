extends "res://src/scripts/body_physics.gd"

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

export (int) var speed = 50
export (int) var damage = 10
export (int) var HP = 100

enum {
	IDLE,
	CHASE,
	DEATH,
	DASH
}

var state = IDLE
var player = null

func _physics_process(delta):
	Motion = move_and_slide(Motion)

	match state:
		IDLE:
			state_idle()
		CHASE:
			state_chase()
		DEATH:
			state_death()

func state_idle():
	animationPlayer.play("idle")
	Motion = Vector2()

func state_chase():
	if player != null:
		animationPlayer.play("run")
		Motion = (player.global_position - global_position).normalized() * speed
		if player.global_position.x > global_position.x:
			sprite.flip_h = false
		else:
			sprite.flip_h = true

func state_death():
	animationPlayer.play("death")

func take_damage(damage):
	HP -= damage
	print(HP)
	
	if HP <= 0:
		state = DEATH

func _on_PlayerDetectionZone_body_entered(body):
#	if body.is_in_group('Player'):
		player = body
		state = CHASE


func _on_PlayerDetectionZone_body_exited(body):
	state = IDLE
	player = null


func _on_hurtBox_body_entered(body):
	take_damage(body.damage)
