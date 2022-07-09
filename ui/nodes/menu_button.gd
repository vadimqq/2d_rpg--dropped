extends Button

onready var sound = $sound


func _on_menu_button_mouse_entered():
	sound.play()
