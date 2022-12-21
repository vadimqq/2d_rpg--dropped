extends Item_with_popup

export (int) var GAIN_CHANCE_BLEED = 5

func _on_jagged_steel_item_entered(body):
	body.STATS.apply_buff({
		"GAIN_CHANCE_BLEED": GAIN_CHANCE_BLEED
	})

func _on_jagged_steel_item_exited(body):
	body.STATS.apply_buff({
		"GAIN_CHANCE_BLEED": -GAIN_CHANCE_BLEED
	})
