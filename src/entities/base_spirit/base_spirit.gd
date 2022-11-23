extends KinematicBody2D
class_name Base_spirit

onready var sprite = $Sprite
onready var first_skill_timer:Timer = $first_skill_timer

export (int) var BASE_ACCELERATION = 2000
export (int) var ACCELERATION = BASE_ACCELERATION

var player: Player

var Motion = Vector2.ZERO
var axis = Vector2.ZERO
var MOVE_SPEED = 50
var MAX_DISTANCE = 20
enum {
	CHASE,
	IDLE,
}
var state = CHASE

signal cast_first_skill
signal cast_second_skill
signal cast_third_skill
signal cast_fourth_skill


func _ready():
	yield(get_tree(), "idle_frame")
	player = GAME_CORE.player

func _physics_process(delta):
	if player != null:
		axis = (player.global_position - global_position).normalized()
		MOVE_SPEED = global_position.distance_to(player.global_position) + 50
		match state:
			CHASE:
				state_move(delta)
			IDLE:
				state_idle(delta)
		
		if global_position.distance_to(player.global_position) > MAX_DISTANCE:
			state = CHASE
		else:
			state = IDLE
		
		if player.global_position > global_position:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		
		Motion = move_and_slide(Motion)

func apply_friction(amount):
	if Motion.length() > amount:
		Motion -= Motion.normalized() * amount
	else: 
		Motion = Vector2.ZERO

func apply_movement(accel, speed):
	Motion += accel
	Motion = Motion.clamped(speed)

func state_idle(delta):
	apply_friction((MOVE_SPEED * 10) * delta)

func state_move(delta):
	apply_movement(axis * (MOVE_SPEED * 10) * delta, MOVE_SPEED)

#func first_skill():
#	emit_signal("cast_first_skill")
#	first_skill_timer.start()
#
#func second_skill():
#	 emit_signal("cast_second_skill")
#
#func third_skill():
#	 emit_signal("cast_third_skill")
#
#func fourth_skill():
#	 emit_signal("cast_fourth_skill")
