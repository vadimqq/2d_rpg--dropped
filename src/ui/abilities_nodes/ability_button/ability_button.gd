extends TextureRect

onready var lvl_label = $Lvl
onready var button = $TextureButton
onready var lock = $Lock

export (String) var ability_name = ''
var price = 1
var is_max_lvl = false
var disabled_color = "#5b5a5a"
var active_color = "#ffffff"

func _ready():
	CURRENCY_MANAGER.connect("change_upgrade_points", self, "on_change_upgrade_points")

func set_unlock():
	lock.visible = false
	button.disabled = false
	on_change_upgrade_points()

func set_ability_name_label():
	pass

func set_ability_lvl_label(new_lvl):
	lvl_label.text = str(new_lvl)

func _on_TextureButton_button_down():
	var ability: Base_ability = GAME_CORE.player.ability_list.get_node(ability_name)
	ability.upgrade()
	CURRENCY_MANAGER.modify_upgrade_points(-ability.price)
	set_ability_lvl_label(ability.lvl)
	is_max_lvl = ability.is_max_lvl
	on_change_upgrade_points()

func on_change_upgrade_points():
	if price <= CURRENCY_MANAGER.upgrade_points && !lock.visible && !is_max_lvl:
		button.disabled = false
		button.modulate = active_color
	else:
		button.disabled = true
		button.modulate = disabled_color
