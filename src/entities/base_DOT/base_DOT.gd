extends Node2D

class_name Base_DOT

signal apply_damage

onready var timer: Timer = $Timer

var enemy = null
var stack = 0
var time = 3.0

func up_stack(amount):
	stack += amount
	timer.wait_time = time
	timer.start()

func _on_Timer_timeout():
	stack = 0

func apply_damage(s):
	if stack > 0:
		emit_signal("apply_damage", s)

func update_info(s):
	enemy = s
