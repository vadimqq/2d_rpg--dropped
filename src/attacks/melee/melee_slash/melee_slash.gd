extends Base_melee_attack

onready var animation = $Animation

func _ready():
	type = CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC
	animation.play("attack")

func _on_arrow_area_entered(area):
	is_hit = true

func _on_arrow_body_entered(body):
	is_hit = true
