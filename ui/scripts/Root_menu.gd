extends Control

func _ready():
	pass
	OS.window_fullscreen = true

func _on_button_play_pressed():
	get_tree().change_scene("res://src/Arena.tscn")

func _on_button_exit_pressed():
	get_tree().quit()
