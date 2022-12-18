extends Base_item

class_name Item_with_popup

onready var popup: Popup = $CanvasLayer/Popup
onready var popup_description = $CanvasLayer/Popup/MarginContainer/VBoxContainer/Description
onready var popup_name = $CanvasLayer/Popup/MarginContainer/VBoxContainer/Name

var is_monitoring = false
var description = ''

func _process(delta):
	if Input.is_action_just_pressed("action") && is_monitoring:
		match type:
			CONSTANTS.ITEM_TYPE_ENUM.WEAPON:
				pass
#				WEAPON_MANAGER.take_weapon(self)
			CONSTANTS.ITEM_TYPE_ENUM.ARTIFACT:
				OBJECT_MANAGER.take_item(self)
		queue_free()

func _on_Item_with_popup_body_entered(body):
	popup_name.text = "<< " + item_name + " >>"
	popup_description.text = "Description: " + description
	popup.popup()
	is_monitoring = true

func _on_Item_with_popup_body_exited(body):
	popup.hide()
	is_monitoring = false
