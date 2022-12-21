extends CenterContainer

const choise_button = preload("res://src/ui/abilities_nodes/current_abilities/choise_ability_button/choise_ability_button.tscn")

onready var ability_ui: Ability_ui = $Ability_ui
onready var ability_list = $Control/VBoxContainer

export (int) var tier = 1

func _on_Choise_toggled(button_pressed):
	if ability_list.visible:
		hide_ability_list()
	else:
		var player: Base_body = find_parent("Player")
		var active_weapon: Base_weapon = player.W_M.get_active_weapon()
		
		for ability in player.ability_list.get_children():
			var is_tag_intersection = false
			for ability_tag in ability.weapon_tags:
				if ability_tag == CONSTANTS.WEAPON_TYPES.ALL:
					is_tag_intersection = true
					break
				if is_tag_intersection:
					break
				for weapon_tag in active_weapon.tags:
					if ability_tag == weapon_tag:
						is_tag_intersection = true
						break
			if ability.tier == tier && ability.lvl > 0 && is_tag_intersection:
				var instance: Choise_button = choise_button.instance()
				instance.set_ability(ability)
				instance.connect("set_new_abillity", self, "set_new_ability")
				ability_list.add_child(instance)
		show_ability_list()
	
func set_new_ability(ability: Base_ability):
	hide_ability_list()
	ability_ui.connect_ability(ability)

func show_ability_list():
	ability_list.visible = true

func hide_ability_list():
	ability_list.visible = false
	for node in ability_list.get_children():
		node.queue_free()
