extends Position2D

onready var label = $Label
onready var tween = $Tween

var velocity = Vector2.ZERO
var max_size = Vector2(1, 1)

func execute(node: KinematicBody2D, amount, type):
	label.text = str(amount)
	self.global_position = node.global_position
#	get_tree().get_root().add_child(self)

	match type:
		CONSTANTS.CAST_TYPE_ENUM.HEAL:
			label.set("custom_colors/font_color", Color("2eff27"))
		CONSTANTS.CAST_TYPE_ENUM.BASE:
			label.set("custom_colors/font_color", Color("f1be0e"))
		CONSTANTS.CAST_TYPE_ENUM.CRITICAL:
			label.set("custom_colors/font_color", Color("ff3131"))
			max_size = Vector2(1.5, 1.5)
			
	randomize()
	var slide_movement = randi() % 81 - 40
	velocity = Vector2(slide_movement, 25)
	tween.interpolate_property(self, 'scale', scale, max_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.interpolate_property(self, 'scale', max_size, Vector2(0.1, 0.1), 0.7,  Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()


func _on_Tween_tween_all_completed():
	queue_free()

func _process(delta):
	position -= velocity * delta
