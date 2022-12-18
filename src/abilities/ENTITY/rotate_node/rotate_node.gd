extends Node2D

var rotate_speed = 20
var radius = 20

func _ready():
	var step = 2 * PI / get_child_count()
	
	for i in get_child_count():
		var pos = Vector2(radius, 0).rotated(step * i)
		get_child(i).position = pos
		get_child(i).rotation = pos.angle()

func _process(delta):
	var new_rotation = rotation_degrees + rotate_speed * delta
	rotation_degrees = fmod(new_rotation, 360)
