extends LinkButton

@export var scene_to_load: String

func _on_level_pressed():
	var transition_layer = get_tree().get_first_node_in_group("transition")
	if transition_layer:
		transition_layer.change_scene(str("res://scenes/" + scene_to_load + ".tscn"))
	#get_tree().change_scene_to_file("res://scenes/" + scene_to_load + ".tscn")
