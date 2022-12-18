extends Position2D

onready var timer = $Timer

signal spawned(spawn)

export (PackedScene) var spawning_scene
export (int) var spawn_time = 5

func _ready():
	timer.wait_time = spawn_time
	timer.start()

func spawn():
	var spawning: Enemy = spawning_scene.instance()
	spawning.lvl = GAME_CORE.game_lvl
	get_tree().get_current_scene().y_sort.add_child(spawning)
	spawning.global_position = global_position
	
	emit_signal("spawned", spawning)
	spawning.start_chase()
	return spawning

func _on_Timer_timeout():
	spawn()
