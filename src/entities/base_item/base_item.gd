extends Node2D

class_name Base_item

signal item_entered
signal item_exited

onready var sprite = $Sprite

var count = 1
export (String) var id
export (String) var item_name = ''
export (String) var description = ''
export (CONSTANTS.ITEM_TYPE_ENUM) var type = CONSTANTS.ITEM_TYPE_ENUM.ARTIFACT

func set_item(body):
	get_parent().remove_child(self)
	emit_signal("item_entered", body)

func remove_item(body):
	emit_signal("item_exited", body)
