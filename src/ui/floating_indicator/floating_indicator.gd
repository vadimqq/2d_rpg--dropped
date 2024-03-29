extends Position2D

onready var label = $Label
onready var tween = $Tween

var velocity = Vector2.ZERO
var max_size = Vector2(1, 1)

func execute(node: KinematicBody2D, amount, type):
	label.text = str(amount)
	self.global_position = node.global_position

	match type:
		CONSTANTS.DAMAGE_WEIGHT_ENUM.BASE:
			label.set("custom_colors/font_color", Color("f1be0e"))
		CONSTANTS.DAMAGE_WEIGHT_ENUM.CRITICAL:
			label.set("custom_colors/font_color", Color("ff3131"))
			max_size = Vector2(1.5, 1.5)
		
	randomize()
	var slide_movement = randi() % 81 - 40
	velocity = Vector2(slide_movement, 25)
	tween.interpolate_property(self, 'scale', scale, max_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.interpolate_property(self, 'scale', max_size, Vector2(0.1, 0.1), 0.7,  Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()


func execute_DOT(node: KinematicBody2D, amount, type):
	label.text = str(amount)
	self.global_position = node.global_position

	max_size = Vector2(0.5, 0.5)
	match type:
		CONSTANTS.EFFECT_TAG_ENUM.BLEED:
			label.set("custom_colors/font_color", Color("a20000"))
		CONSTANTS.EFFECT_TAG_ENUM.POISON:
			label.set("custom_colors/font_color", Color("038019"))
		
	randomize()
	var slide_movement = randi() % 81 - 40
	velocity = Vector2(slide_movement, 25)
	tween.interpolate_property(self, 'scale', scale, max_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.interpolate_property(self, 'scale', max_size, Vector2(0.1, 0.1), 0.5,  Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.2)
	tween.start()


func _on_Tween_tween_all_completed():
	queue_free()

func _process(delta):
	position -= velocity * delta
