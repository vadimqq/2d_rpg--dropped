extends Node2D

export var rotation_speed = 1

var speed = 1.0
var max_spirit_count = 4
var radius = 70

var spirits_pool = []

func _process(delta):
	for spirit in spirits_pool:
		spirit['d'] += delta
		spirit['node'].rotation = -rotation
		spirit['node'].global_position = Vector2(
			sin(spirit['d'] * speed) * radius,
			cos(spirit['d'] * speed) * radius
		) + global_position


func add_new_spirit(spirit_instance):
	var distance = 6.1
	spirits_pool.push_back({
		"d": 0,
		"node": spirit_instance
	})
	var step = distance / (spirits_pool.size()) if spirits_pool.size() > 1 else 1.0
	for spirit in spirits_pool:
		spirit["d"] = distance
		distance -= step
	add_child(spirit_instance)
