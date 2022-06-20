extends Node2D

var velocity = Vector2()

func _physics_process(delta):
		look_at(get_global_mouse_position())
