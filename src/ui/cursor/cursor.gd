extends Node2D

onready var animation = $Animation

func _ready():
	set_as_toplevel(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	animation.play("idle")

func _process(delta):
	global_position = get_global_mouse_position()
