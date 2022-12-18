extends CenterContainer

const choise_button = preload("res://src/ui/abilities_nodes/current_abilities/choise_ability_button/choise_ability_button.tscn")

onready var ability_ui: Ability_ui = $Ability_ui
onready var ability_list = $Control/VBoxContainer

export (int) var tier = 1

func _on_Choise_toggled(button_pressed):

	if ability_list.visible:
		ability_list.visible = false
		for node in ability_list.get_children():
			node.queue_free()
	else:
		var player: Base_body = find_parent("Player")
		for ability in player.ability_list.get_children():
			if ability.tier == tier && ability.lvl > 0 && ability_ui.ability.name != ability.name:
				var instance: Choise_button = choise_button.instance()
				instance.set_ability_name(ability.name)
				instance.set_ability_texture(load("res://src/abilities/" + ability.name + "/icon.png"))
				ability_list.add_child(instance)
		ability_list.visible = true
		
