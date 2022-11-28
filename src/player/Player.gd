extends Base_body

class_name Player

var is_combat = false

var attack_layer = 8
var attack_mask = 129

func _physics_process(delta):
	axis = get_input_axis()
	ray_cast.look_at(get_global_mouse_position())

	if Input.is_action_pressed("weapon_skill") && !weapon_slot.get_children().empty():
		is_combat = true
		WEAPON_MANAGER.active.use_weapon_ability(self)
	else:
		is_combat = false
	if Input.is_action_pressed("first_skill") && WEAPON_MANAGER.active.slot_1.get_child_count() > 0 && WEAPON_MANAGER.active.slot_1.get_child(0).is_ready && WEAPON_MANAGER.active.slot_1.get_child(0).mana_cost < STATS.MANA:
		WEAPON_MANAGER.active.use_first_ability(self)
	if Input.is_action_pressed("second_skill") && WEAPON_MANAGER.active.slot_2.get_child_count() > 0 && WEAPON_MANAGER.active.slot_2.get_child(0).is_ready && WEAPON_MANAGER.active.slot_2.get_child(0).mana_cost < STATS.MANA:
		WEAPON_MANAGER.active.use_second_ability(self)
	if Input.is_action_pressed("third_skill") && WEAPON_MANAGER.active.slot_3.get_child_count() > 0 && WEAPON_MANAGER.active.slot_3.get_child(0).is_ready && WEAPON_MANAGER.active.slot_3.get_child(0).mana_cost < STATS.MANA:
		WEAPON_MANAGER.active.use_third_ability(self)
	if Input.is_action_pressed("fourth_skill") && WEAPON_MANAGER.active.slot_4.get_child_count() > 0 && WEAPON_MANAGER.active.slot_4.get_child(0).is_ready && WEAPON_MANAGER.active.slot_4.get_child(0).mana_cost < STATS.MANA:
		WEAPON_MANAGER.active.use_fourth_ability(self)
	if Input.is_action_pressed("weapon_swap"):
		WEAPON_MANAGER.swap_weapon(self)
	
	match state:
		MOVE:
			animation_tree.get("parameters/playback").travel("move")
	animation_tree.set("parameters/idle/blend_position", get_global_mouse_position() - global_position)
	animation_tree.set("parameters/move/blend_position", get_global_mouse_position() - global_position)
	
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

func _on_Player_death():
	print('GG')
