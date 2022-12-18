extends Node2D

onready var y_sort = $YSort
onready var timer = $Timer

export (int) var lvl_duration = 300

func _ready():
#	GAME_CORE.game_ui.game_time.progress.max_value = lvl_duration
	timer.wait_time = lvl_duration
	timer.start()

func _process(delta):
	GAME_CORE.time_left = timer.time_left
#	GAME_CORE.game_ui.game_time.progress.value = timer.time_left


func _on_Timer_timeout():
	pass # Replace with function body.

func add_player():
	get_tree().get_current_scene().y_sort.add_child(GAME_CORE.player)
