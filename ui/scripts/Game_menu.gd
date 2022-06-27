extends Container

onready var button_restart = $Menu/VBoxContainer/button_restart

func _ready():
	visible = false
#	set_as_toplevel(true)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			close_menu()
		else:
			open_menu()

func open_menu():
	get_tree().paused = true
	visible = true

func close_menu():
	get_tree().paused = false
	visible = false

func restart_game():
	get_tree().change_scene("res://src/HellMode.tscn")
	close_menu()

func exit():
	get_tree().change_scene("res://ui/Root_menu.tscn")
	close_menu()

func _on_button_restart_pressed():
	restart_game()


func _on_Exit_pressed():
	exit()
