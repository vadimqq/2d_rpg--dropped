extends Sprite

onready var tween = $Tween

func _ready():
	tween.interpolate_property(self, 'modulate:a', 1.0, 0.0, 2, 3, 1)
	tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
