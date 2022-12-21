extends TextureButton

class_name Choise_button

signal set_new_abillity

var ability: Base_ability = null

func set_ability(new_ability: Base_ability):
	texture_normal = load("res://src/abilities/" + new_ability.name + "/icon.png")
	ability = new_ability

func _on_TextureButton_button_up():
	var player: Base_body = find_parent("Player")
	player.W_M.get_active_weapon().set_ability_by_tier(ability)
	emit_signal("set_new_abillity", ability)
