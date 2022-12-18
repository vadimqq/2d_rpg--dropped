extends HBoxContainer

class_name Base_quest

signal update

onready var label_name = $name
onready var label_condition = $condition
onready var label_status = $status

var quest_name = ''
var quest_description = ''

var is_complite = false

var kills = 0

var shrine = 0

func update():
	emit_signal("update")
	label_status.text = 'complite' if is_complite else ''
