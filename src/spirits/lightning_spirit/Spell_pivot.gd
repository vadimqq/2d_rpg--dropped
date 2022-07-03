extends Node2D


export var rotation_speed = 1

func _process(delta):
	rotation += rotation_speed * delta
	for spirit_wrapper in get_children():
		spirit_wrapper.rotation = -rotation
