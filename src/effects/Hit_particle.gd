extends Particles2D

func _ready():
	emitting = true
	yield(get_tree().create_timer(lifetime), "timeout")
	queue_free()

func swich_rotation(pos, s):
	global_position = s.global_position
	rotation = get_angle_to(pos.global_position) + PI
