extends Position2D

signal spawned(spawn)

export (PackedScene) var spawning_scene

func spawn():
	var spawning = spawning_scene.instance()
	
	get_tree().get_current_scene().y_sort.add_child(spawning)
	spawning.global_position = global_position
	
	emit_signal("spawned", spawning)
	return spawning


func _on_Timer_timeout():
	spawn()
