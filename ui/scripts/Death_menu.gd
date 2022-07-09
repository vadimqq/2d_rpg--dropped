extends Container

func _ready():
	visible = false

func open():
	get_tree().paused = true
	visible = true

func _on_Restart_button_up():
	GAME_CORE.load_lvl()


func _on_Menu_button_up():
	get_tree().paused = false
	get_tree().change_scene("res://ui/Root_menu.tscn")
