extends Base_body

class_name Base_NPC

onready var clue = $Clue

var in_range = false

func _ready():
	animation.play("idle")

func _on_Hurtbox_body_entered(body):
	clue.visible = true
	in_range = true

func _on_Hurtbox_body_exited(body):
		clue.visible = false
		in_range = false
