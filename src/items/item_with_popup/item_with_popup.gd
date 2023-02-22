extends Base_item

class_name Item_with_popup

signal take_ability_scroll

onready var popup: Popup = $CanvasLayer/Popup
onready var popup_description = $CanvasLayer/Popup/MarginContainer/VBoxContainer/Description
onready var popup_name = $CanvasLayer/Popup/MarginContainer/VBoxContainer/Name

var is_monitoring = false
var player_body = null

func _process(delta):
	if Input.is_action_just_pressed("action") && is_monitoring:
		match type:
			CONSTANTS.ITEM_TYPE_ENUM.WEAPON:
				pass
#				WEAPON_MANAGER.take_weapon(self)
			CONSTANTS.ITEM_TYPE_ENUM.ARTIFACT:
				player_body.set_new_item(self)
			CONSTANTS.ITEM_TYPE_ENUM.ABILITY_SCROLL:
				emit_signal("take_ability_scroll")
		queue_free()

func _on_Area2D_body_entered(body):
	player_body = body
	popup_name.text = "<< " + item_name + " >>"
	popup_description.text = "Description: " + description
	popup.popup()
	is_monitoring = true


func _on_Area2D_body_exited(body):
	player_body = null
	popup.hide()
	is_monitoring = false
