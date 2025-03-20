extends Label

func _process(delta):
	self.text = "Lives : " + str(global.lives) + "  Coins : " + str(global.coins)
