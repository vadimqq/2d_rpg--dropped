extends Base_projectile

onready var one_step_timer = $One_step_timer
onready var duration_timer = $Duration

export var duration = 0.2

var effect = null
var counter_step = 0

func _on_One_step_timer_timeout():
	var instance = effect.instance()
	instance.load_info(owner_body, transform, 0, damage_tags, damage)
	get_node("/root").add_child(instance)
	instance.global_position.y = rand_range(global_position.y + counter_step, global_position.y - counter_step)
	counter_step += 3 * (owner_body.STATS.get_increase_area() / 100)

func _on_Duration_timeout():
	queue_free()

func start():
	duration_timer.wait_time = duration
	duration_timer.start()
	one_step_timer.start()
