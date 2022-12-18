extends Base_ability

onready var accumulated_timer = $accumulated_timer

export (float) var accumulated_time = 1

func execute():
	accumulated_timer.start()


func _on_accumulated_timer_timeout():
	pass # Replace with function body.
