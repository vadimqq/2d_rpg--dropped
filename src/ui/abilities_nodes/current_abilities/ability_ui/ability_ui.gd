extends TextureProgress

class_name Ability_ui

onready var particle = $Particle
onready var particle_2 = $Particle2

var is_active = false
var ability: Base_ability = null

func _process(delta):
	particle.emitting = is_active
	particle_2.emitting = is_active
	if ability != null:
		value = ability.cd_timer.time_left

func connect_ability(new_ability: Base_ability):
	if new_ability != null:
		if new_ability.is_connected('use_ability', self, "on_use_ability"):
			new_ability.disconnect('use_ability', self, "on_use_ability")
		texture_under = new_ability.icon
		new_ability.connect('use_ability', self, "on_use_ability", [new_ability])
		max_value = new_ability.CD
		ability = new_ability
	else:
		texture_under = load("res://panel_skill.png")
		ability = null
		value = 0
		max_value = 1

func on_use_ability(ability: Base_ability):
	max_value = ability.CD
