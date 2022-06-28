extends Container

onready var upgrade_panel = $CenterContainer/PanelContainer
onready var stat_button = $CenterContainer/Button_up_stat

var player_instance = null

func _ready():
	visible = false

func open_upgrade(player):
	stat_button.menu_root = self
	player_instance = player
	var player_stats = get_structured_stats(player)
	get_tree().paused = true
	visible = true
	
	for stat_type in player_stats:
		var new_stat_button = stat_button.duplicate()
		upgrade_panel.add_child(new_stat_button)
		new_stat_button.menu_root = self
		var stat_label = new_stat_button.get_child(0)
		stat_label.text = str(stat_type['name'])
		new_stat_button.set_stat(stat_type['stats_change'])
		new_stat_button.visible = true

func close_upgrade():
	get_tree().paused = false
	visible = false


func get_structured_stats(player):
	var player_stats_adapter = [
		{
			"name": 'STR',
			"stats_change": [
				{
					"name": 'HP',
					"current_value": player.MAX_HP,
					"next_value": (player.STRENGTH + player.STAT_PER_LVL) * player.strength_hp_scale
				},
				{
					"name": 'DMG',
					"current_value": player.damage,
					"next_value": ((player.STRENGTH + player.STAT_PER_LVL) * player.strength_damage_scale) + (player.AGILITY * player.agility_damage_scale) + (player.INTELLIGENCE * player.intellegence_damage_scale)
				}
			]
		},
		{
			"name": 'AGI',
			"stats_change": [
				{
					"name": 'ASPD',
					"current_value": 'доделать',
					"next_value": 'доделать'
				},
				{
					"name": 'DMG',
					"current_value": player.damage,
					"next_value": (player.STRENGTH * player.strength_damage_scale) + ((player.AGILITY + player.STAT_PER_LVL) * player.agility_damage_scale) + (player.INTELLIGENCE * player.intellegence_damage_scale)
				},
				{
					"name": 'SPD',
					"current_value": player.speed,
					"next_value": player.speed + (player.STAT_PER_LVL * player.agility_movement_speed_scale)
				}
			]
		},
		{
			"name": 'INT',
			"stats_change": [
				{
					"name": 'MP',
					"current_value": player.MAX_MANA,
					"next_value": (player.INTELLIGENCE + player.STAT_PER_LVL) * player.intellegence_mana_scale
				},
				{
					"name": 'DMG',
					"current_value": player.damage,
					"next_value": (player.STRENGTH * player.strength_damage_scale) + ((player.AGILITY) * player.agility_damage_scale) + ((player.INTELLIGENCE + player.STAT_PER_LVL) * player.intellegence_damage_scale)
				},
				{
					"name": 'CDR',
					"current_value": str(player.cd_reduction) + '%',
					"next_value": str(player.cd_reduction + player.STAT_PER_LVL if player.cd_reduction + player.STAT_PER_LVL < 99 else 99) + '%',
				},
			]
		}
	]
	return player_stats_adapter


func upgrade_stat_by_name(stat_name):
	match stat_name:
		'STR':
			player_instance.up_STR()
		'INT':
			player_instance.up_INT()
		'AGI':
			player_instance.up_AGI()
	close_upgrade()
	for button in upgrade_panel.get_children():
		button.queue_free()
	
