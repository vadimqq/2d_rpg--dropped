extends "res://src/scripts/body_physics.gd"

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var player_detection_zone = $PlayerDetectionZone
onready var hurt_box = $hurtBox 

export (int) var speed = 50
export (int) var damage = 10
export (int) var HP = 100

export var take_damage_time = 0.2

enum {
	IDLE,
	CHASE,
	DEATH,
	TAKE_DAMAGE
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
		TAKE_DAMAGE:
			state_take_damage(delta)

# Для спавнера сурвайвл режима
func start_player_chase(player_body):
	player_detection_zone.monitorable = false
	player_detection_zone.monitoring = false
	player = player_body
	state = CHASE

func take_damage(damage):
	HP -= damage
	state = TAKE_DAMAGE

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
	Motion = Vector2()
	hurt_box.monitoring = false
	hurt_box.monitorable = false
	sprite.rotation_degrees = 90
	animationPlayer.play("death")

func state_take_damage(delta):
	Motion = Motion.move_toward(Vector2.ZERO, 700 * delta)
	Motion = move_and_slide(Motion)

	animationPlayer.play("take_damage")
	sprite.material.set_shader_param('whiten', true)
	yield(get_tree().create_timer(take_damage_time), "timeout")
	sprite.material.set_shader_param('whiten', false)

	if HP <= 0:
		state = DEATH
	elif player != null:
		state = CHASE
	else:
		state = IDLE

func _on_PlayerDetectionZone_body_entered(body):
		player = body
		state = CHASE

func _on_PlayerDetectionZone_body_exited(body):
	state = IDLE
	player = null

func _on_hurtBox_area_entered(area):
	var weapon = area.get_parent()
	Motion = (global_position - weapon.global_position) * weapon.knockback_power
	take_damage(weapon.damage)


func _on_hitBox_area_entered(area):
	pass # Replace with function body.
