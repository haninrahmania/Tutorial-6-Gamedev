extends Area2D

@export var sceneName: String


func _on_Area_Trigger_body_entered(body):
	var current_scene = get_tree().get_current_scene().get_name()
	if body.get_name() == "Player":
		if current_scene == sceneName:
			global.lives -=1
			global.coins ==0
		if (global.lives == 0):
			get_tree().change_scene_to_file(str("res://scenes/Game Over.tscn"))
		else:
			var transition_layer = get_tree().get_first_node_in_group("transition")
			if transition_layer:
				transition_layer.change_scene(str("res://scenes/" + sceneName + ".tscn"))
			#get_tree().call_deferred("change_scene_to_file",(str("res://scenes/" + sceneName + ".tscn")))
