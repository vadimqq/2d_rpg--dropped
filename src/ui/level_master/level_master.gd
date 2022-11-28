extends CanvasLayer

class_name Level_master


func show():
	visible = true

func hide():
	visible = false


func _on_Button_button_down():
	LOCATION_MANAGER.load_location(LOCATION_MANAGER.GLADE)
