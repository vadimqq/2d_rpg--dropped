extends ViewportContainer

onready var Hp_bar = $VBoxContainer/HP
onready var Mana_bar = $VBoxContainer/MANA

var player = null

## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


func _process(delta):
	Hp_bar.value = player.HP
	Mana_bar.value = player.MANA

func load_player(playerInfo):
	player = playerInfo
	Hp_bar.max_value = player.MAX_HP
	Mana_bar.max_value = player.MAX_MANA
	
