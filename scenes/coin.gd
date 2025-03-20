extends Area2D

func _on_coin_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		global.coins +=1
		queue_free()
