extends Position2D

var orc = preload("res://src/enemies/pig/pig.tscn")
#var orc = preload("res://src/enemies/skull/skull.tscn")


onready var timer = $Timer
onready var timer_lvl_up = $LVL_UP

func _ready():
	timer.wait_time = 7
	timer.start()
	timer_lvl_up.start()

func _on_Timer_timeout():
	var orc_instance = orc.instance()

	owner.add_child(orc_instance)
	orc_instance.position = position
	orc_instance.start_player_chase(get_tree().get_nodes_in_group('player')[0])

	timer.start()


func _on_LVL_UP_timeout():
	timer.wait_time -= 0.5
