extends CanvasLayer

class_name Level_master

func show():
	visible = true

func hide():
	visible = false


func _on_Button_button_down():
	LOCATION_MANAGER.load_location(LOCATION_MANAGER.GLADE)
	QUEST_MANAGER.add_new_quest('harvest')

func _on_Button2_button_down():
	LOCATION_MANAGER.load_location(LOCATION_MANAGER.generate_map)
