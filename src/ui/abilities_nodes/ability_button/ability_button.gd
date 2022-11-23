extends TextureRect

onready var lvl_label = $Lvl
onready var price_label = $Price
onready var button = $TextureButton
onready var lock = $Lock

var ability_name = null
var price = 0
var lvl = 0
var max_lvl = 0
var pick_lock = true
var ability_type = CONSTANTS.ABILITY_TYPE_ENUM.ACTIVE

func _process(delta):
	if GAME_CORE.soul_stones < price || lvl == max_lvl:
		button.disabled = true
	else:
		button.disabled = false

func _on_TextureButton_button_down():
	if ability_name != null:
		SKILL_MANAGER.upgrade_ability(ability_name)
		load_info()

func load_info():
	var ability: Base_ability = SKILL_MANAGER.get_ability_by_name(ability_name)
	lvl_label.text = str(ability.lvl)
	lvl = ability.lvl
	max_lvl = ability.max_lvl
	price = ability.price
	if (ability.max_lvl == ability.lvl):
		price_label.text = ''
	else:
		price_label.text = str(ability.price)

	pick_lock = true
	lock.visible = true

	if ability.tags.size() > WEAPON_MANAGER.active.tags.size():
		for tag in ability.tags:
			if WEAPON_MANAGER.active.tags.has(tag):
				pick_lock = false
	elif ability.tags.size() == 0:
		pick_lock = false
	else:
		for tag in WEAPON_MANAGER.active.tags:
			if ability.tags.has(tag):
				pick_lock = false
	lock.visible = pick_lock

func _on_TextureButton_gui_input(event: InputEvent):
	if event.is_action_pressed("set_ability") && !pick_lock && int(lvl_label.text) > 0:
		match ability_type:
			CONSTANTS.ABILITY_TYPE_ENUM.ACTIVE:
				SKILL_MANAGER.set_active_ability(ability_name)
