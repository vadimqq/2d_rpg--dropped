extends Base_body

class_name Player

onready var camera: Camera2D = $Camera2D
onready var animation_tree: AnimationTree = $AnimationTree
onready var game_ui = $Game_ui
onready var A_M = $Ability_manager
onready var W_M = $Weapon_manager

var freeze_slow = 0.4

var attack_layer = 8
var attack_mask = 129
var enemy_body_layer = 32

func _ready():
	W_M.load_weapon("bow")
	W_M.load_weapon("staff")
	game_ui.connect_stats_system(STATS)
	game_ui.connect_weapon_manager(W_M)

func _physics_process(delta):
	axis = get_input_axis()
	ray_cast.look_at(get_global_mouse_position())

	if Input.is_action_pressed("weapon_skill") && !weapon_slot.get_children().empty() && W_M.active.get_base_ability_mana_cost() <= STATS.CURRENT_MANA:
		is_combat = true
		W_M.active.use_weapon_ability(self)
	else:
		is_combat = false
	if Input.is_action_pressed("first_skill") && W_M.active.get_ability_by_slot(1) != null && W_M.active.get_ability_by_slot(1).is_ready && W_M.active.get_ability_by_slot(1).mana_cost <= STATS.CURRENT_MANA:
		W_M.active.use_first_ability(self)
	if Input.is_action_pressed("second_skill") && W_M.active.get_ability_by_slot(2) != null && W_M.active.get_ability_by_slot(2).is_ready && W_M.active.get_ability_by_slot(2).mana_cost <= STATS.CURRENT_MANA:
		W_M.active.use_second_ability(self)
	if Input.is_action_pressed("third_skill") && W_M.active.get_ability_by_slot(3) != null && W_M.active.get_ability_by_slot(3).is_ready && W_M.active.get_ability_by_slot(3).mana_cost <= STATS.CURRENT_MANA:
		W_M.active.use_third_ability(self)
	if Input.is_action_pressed("fourth_skill") && W_M.active.get_ability_by_slot(4) != null && W_M.active.get_ability_by_slot(4).is_ready && W_M.active.get_ability_by_slot(4).mana_cost <= STATS.CURRENT_MANA:
		W_M.active.use_fourth_ability(self)
	if Input.is_action_pressed("weapon_swap"):
		W_M.swap_weapon()
	
	match state:
		MOVE:
			animation_tree.get("parameters/playback").travel("move")
		IDLE:
			animation_tree.get("parameters/playback").travel("idle")
	animation_tree.set("parameters/idle/blend_position", get_global_mouse_position() - global_position)
	animation_tree.set("parameters/move/blend_position", get_global_mouse_position() - global_position)
	
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

func _on_Player_death():
	set_physics_process(false)
	animation_tree.get("parameters/playback").travel("dead")

func freeze_time():
	Engine.time_scale = freeze_slow

func restart():
	Engine.time_scale = 1
	GAME_CORE.end_game()
