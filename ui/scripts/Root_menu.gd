extends Control

onready var audio = $Audio

func _ready():
	pass
	OS.window_fullscreen = true
	audio.play()
	
func _on_button_exit_pressed():
	GAME_CORE.close_main_menu()

func _on_button_play_pressed():
	GAME_CORE.load_lvl()
