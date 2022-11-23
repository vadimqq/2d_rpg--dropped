extends Base_body

class_name Player

var is_combat = false

var attack_layer = 8
var attack_mask = 129

func _ready():
	STATS = Stat_system.new(base_stats)
	on_stats_init()

func _physics_process(delta):
	axis = get_input_axis()
	ray_cast.look_at(get_global_mouse_position())

	if Input.is_action_pressed("weapon_skill") && !weapon_slot.get_children().empty():
		is_combat = true
		WEAPON_MANAGER.active.use_weapon_ability(self)
	else:
		is_combat = false
	if Input.is_action_pressed("first_skill") && SKILL_MANAGER.weapon_1_tier_1_ability != null && SKILL_MANAGER.weapon_1_tier_1_ability.is_ready:
		WEAPON_MANAGER.active.use_first_ability(self)
	if Input.is_action_pressed("second_skill") && SKILL_MANAGER.weapon_1_tier_2_ability != null && SKILL_MANAGER.weapon_1_tier_2_ability.is_ready:
		WEAPON_MANAGER.active.use_second_ability(self)
	if Input.is_action_pressed("third_skill") && SKILL_MANAGER.weapon_1_tier_3_ability != null && SKILL_MANAGER.weapon_1_tier_3_ability.is_ready:
		WEAPON_MANAGER.active.use_third_ability(self)
	if Input.is_action_pressed("fourth_skill") && SKILL_MANAGER.weapon_1_tier_4_ability != null && SKILL_MANAGER.weapon_1_tier_4_ability.is_ready:
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

const base_stats = {
	"LVL": 1,
	
	"HP": 100.0,
	"HP_REG": 1.0,
	
	"MANA": 50.0,
	"MANA_REG": 2.0,
	
	"MOVE_SPEED": 100.0,
	"DASH_TIME": 0.3,
	
	"ATTACK_SPEED": 2.0,
	"PROJECTILE_SPEED": 200.0,
	"DAMAGE": 10.0,
	
	"CRIT_CHANCE": 50.0,
	
	"CAST_DURATION": 0.0,
	"INCREASE_AREA": 0.0,
	"KNOCKBACK_POWER": 0.0,
	"CDR": 0.0,
}

func _on_Player_death():
	print('GG')
