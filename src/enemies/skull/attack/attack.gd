extends Area2D

var speed = 0
var damage = 0

func _physics_process(delta):
	position += transform.x * speed * delta


func _ready():
	set_as_toplevel(true)

func fire(new_global_transform, angle, projectile_damage, projectile_speed):
	damage = projectile_damage
	speed = projectile_speed
	transform = new_global_transform
	rotation = angle


func _on_Area2D_area_entered(area):
	queue_free()

func _on_Area2D_body_entered(body):
	queue_free()
