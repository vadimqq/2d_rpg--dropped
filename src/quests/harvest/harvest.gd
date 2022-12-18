extends Base_quest

func _init():
	quest_name = 'Harvest'
	quest_description = 'Kill a certain number of monsters'
	kills =  10

func _ready():
	label_name.text = quest_name
	label_condition.text = str(GAME_CORE.enemy_killing) + "/" + str(kills)

func _on_harvest_update():
	label_condition.text = str(GAME_CORE.enemy_killing) + "/" + str(kills)
	is_complite = kills <= GAME_CORE.enemy_killing
	
