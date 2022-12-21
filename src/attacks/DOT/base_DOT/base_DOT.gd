extends Node

class_name Base_DOT

signal apply_damage

onready var duration_timer: Timer = $Duration
onready var one_tick_timer: Timer = $Tick

export (float) var duration = 3.0
export (float) var one_tick = 0.5

export (int) var damage = 2
var stack = 0

var owner_body = null
var target_body = null

func update_info(body_1, body_2, stack_amount):
	owner_body = body_1
	target_body = body_2
	stack += stack_amount
	calculate_duration_time()
	calculate_one_tick_time()
	duration_timer.start()

func calculate_duration_time():
	duration_timer.wait_time = owner_body.STATS.get_dot_duration(duration)

func calculate_one_tick_time():
	one_tick_timer.wait_time = owner_body.STATS.get_dot_tick_time(one_tick)

func _on_Tick_timeout():
	if stack > 0:
		emit_signal("apply_damage")

func _on_Duration_timeout():
	stack = 0
