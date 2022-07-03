extends Position2D

onready var label = $Label
onready var tween = $Tween

var amount = 0
var velocity = Vector2(0, 0) 

func _ready():
	label.text = str(amount)
	var side_movement = randi() % 81 - 40
	velocity = Vector2(side_movement, 50)
	tween.interpolate_property(self, 'scale', scale, Vector2(1, 1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

func _process(delta):
	position -= velocity * delta 

func _on_Tween_tween_all_completed():
	queue_free()
