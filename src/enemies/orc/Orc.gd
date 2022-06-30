extends "res://src/scripts/body_physics.gd"

var drop = preload("res://src/neutral_Object/Exp_point/Exp_point.tscn")

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
	player_detection_zone.set_block_signals(true)
	player = player_body
	state = CHASE

func take_damage(damage):
	HP -= damage
	state = TAKE_DAMAGE

func on_death():
	var drop_instance = drop.instance()
	get_tree().current_scene.add_child(drop_instance)
	drop_instance.transform = transform
	queue_free()

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

func _on_PlayerDetectionZone_body_exited():
	state = IDLE
	player = null

func _on_hurtBox_area_entered(area):
	var instance = area.get_parent()
#	if instance.knockback_power > 0:
	Motion = (global_position - instance.global_position) * instance.knockback_power
	take_damage(instance.damage)
