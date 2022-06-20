extends Area2D

var speed = null
var damage = null

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Arrow_body_entered(body):
#	if body.is_in_group("mobs"):
#		body.queue_free()
	queue_free()

