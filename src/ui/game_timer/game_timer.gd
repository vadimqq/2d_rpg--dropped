extends HBoxContainer

#class_name Game_timer
#
#onready var progress = $TextureProgress
#onready var time_label = $Label2
#
#func _ready():
#	progress.max_value = GAME_CORE.lvl_time
#
#func _process(delta):
#	progress.value = GAME_CORE.time_left
##	time_label.text = time_convert(GAME_CORE.time_left)
#
#
#func time_convert(time_in_sec):
#	var seconds = time_in_sec%60
#	var minutes = (time_in_sec/60)%60
#	return "%02d:%02d" % [minutes, seconds]
