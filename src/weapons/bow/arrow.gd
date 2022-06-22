extends RigidBody2D

var speed = 0
var damage = 0
var rotated_angle = 0
var knockback_power = 0

func _physics_process(delta):
	position += transform.x * speed * delta


func _ready():
	set_as_toplevel(true)
	apply_impulse(Vector2(), Vector2(speed, 0).rotated(rotated_angle))

# Столкновение с хитбоксом противника
func _on_hitbox_area_entered(area):
	queue_free()


# Столкновение с физическими объектами
func _on_hitbox_body_entered(body):
	queue_free()
