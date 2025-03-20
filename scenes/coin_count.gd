extends Label


func _process(delta):
	self.text = "Coins Collected : " + str(global.coins)
