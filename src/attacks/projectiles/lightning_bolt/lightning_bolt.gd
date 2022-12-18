extends Base_projectile

onready var animation = $Animation

func _ready():
	type = CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC
	
	animation.play("fly")

func _on_arrow_area_entered(area):
	is_hit = true
	queue_free()

func _on_arrow_body_entered(body):
	is_hit = true
	queue_free()
