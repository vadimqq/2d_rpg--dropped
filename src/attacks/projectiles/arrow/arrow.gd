extends Base_projectile

onready var animation = $Animation

func _ready():
	type = CONSTANTS.DAMAGE_TYPE_ENUM.LIGHTING
	check_crit_chance(crit_chance, crit_damage)
	animation.play("fly")

func _on_Lightning_bolt_area_entered(area):
	is_hit = true
	animation.play("hit")

func _on_Lightning_bolt_body_entered(body):
	is_hit = true
	animation.play("hit")
