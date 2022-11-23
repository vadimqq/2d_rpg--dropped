extends HBoxContainer

onready var slot_1: TextureProgress = $Slot_1
onready var slot_2: TextureProgress = $Slot_2
onready var slot_3: TextureProgress = $Slot_3
onready var slot_4: TextureProgress = $Slot_4

func _process(delta):
	var current_weapon: Base_weapon = WEAPON_MANAGER.active
	if current_weapon != null:
		var first_ability: Base_ability = current_weapon.get_ability_by_slot_id(1)
		var second_ability: Base_ability = current_weapon.get_ability_by_slot_id(2)
		var third_ability: Base_ability = current_weapon.get_ability_by_slot_id(3)
		var fourth_ability: Base_ability = current_weapon.get_ability_by_slot_id(4)
	
		if first_ability != null:
			slot_1.max_value = first_ability.CD
			slot_1.value = first_ability.cd_timer.time_left
		else:
			slot_1.max_value = 1
			slot_1.value = 0
		
		if second_ability != null:
			slot_2.max_value = second_ability.CD
			slot_2.value = second_ability.cd_timer.time_left
		else:
			slot_2.max_value = 1
			slot_2.value = 0
		
		if third_ability != null:
			slot_3.max_value = third_ability.CD
			slot_3.value = third_ability.cd_timer.time_left
		else:
			slot_3.max_value = 1
			slot_3.value = 0
		
		if fourth_ability != null:
			slot_4.max_value = fourth_ability.CD
			slot_4.value = fourth_ability.cd_timer.time_left
		else:
			slot_4.max_value = 1
			slot_4.value = 0

func set_ability_icon_by_slot(slot, ability_name):
	match slot:
		1:
			slot_1.texture_under = load("res://src/abilities/"+ ability_name +"/icon.png") 
		2:
			slot_2.texture_under = load("res://src/abilities/"+ ability_name +"/icon.png") 
		3:
			slot_3.texture_under = load("res://src/abilities/"+ ability_name +"/icon.png") 
		4:
			slot_4.texture_under = load("res://src/abilities/"+ ability_name +"/icon.png") 

func set_icons():
	var ability_1: Base_ability = WEAPON_MANAGER.active.get_ability_by_slot_id(1)
	var ability_2: Base_ability = WEAPON_MANAGER.active.get_ability_by_slot_id(2)
	var ability_3: Base_ability = WEAPON_MANAGER.active.get_ability_by_slot_id(3)
	var ability_4: Base_ability = WEAPON_MANAGER.active.get_ability_by_slot_id(4)

	if ability_1 != null:
		slot_1.texture_under = load("res://src/abilities/" + ability_1.name + "/icon.png")
	else:
		slot_1.texture_under = load("res://panel_skill.png")
	if ability_2 != null:
		slot_2.texture_under = load("res://src/abilities/" + ability_2.name + "/icon.png")
	else:
		slot_2.texture_under = load("res://panel_skill.png")
	if ability_3 != null:
		slot_3.texture_under = load("res://src/abilities/" + ability_3.name + "/icon.png")
	else:
		slot_3.texture_under = load("res://panel_skill.png")
	if ability_4 != null:
		slot_4.texture_under = load("res://src/abilities/" + ability_4.name + "/icon.png")
	else:
		slot_4.texture_under = load("res://panel_skill.png")
