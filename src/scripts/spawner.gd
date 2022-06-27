extends Position2D

var orc = preload("res://src/enemies/orc/Orc.tscn")

onready var timer = $Timer

func _ready():
	pass
	timer.wait_time = 4
	timer.start()
	
func _on_Timer_timeout():
	var orc_instance = orc.instance()

	owner.add_child(orc_instance)
	orc_instance.position = position
	orc_instance.start_player_chase(get_tree().get_nodes_in_group('player')[0])

	timer.start()
