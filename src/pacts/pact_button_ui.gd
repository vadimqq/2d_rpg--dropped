extends TextureButton

onready var title = $VBoxContainer/Title
onready var victim = $VBoxContainer/Victim
onready var gift = $VBoxContainer/Gift


func _ready():
	pass # Replace with function body.

func set_title(val: String):
	title.text = val

func set_victim_description(val: String):
	victim.text = val

func set_gift_description(val: String):
	gift.text = val
