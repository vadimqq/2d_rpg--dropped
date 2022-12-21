extends Item_with_popup

export (int) var GAIN_HEALTH = 20

func _on_health_potion_item_entered(body):
	body.STATS.apply_buff({
		"GAIN_HEALTH": GAIN_HEALTH
	})

func _on_health_potion_item_exited(body):
	body.STATS.apply_buff({
		"GAIN_HEALTH": -GAIN_HEALTH
	})
