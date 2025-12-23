extends Area2D

var transition_num = 0
# Called when the node enters the scene tree for the first time.




func _on_body_entered(body: Node2D) -> void:
	var scene_name =  get_tree().get_current_scene().name
	if body.is_in_group("Player") and scene_name == "world" :
		
		LevelTransitions.change_scene_to("uid://bguqgq5hmp3td")
		get_tree().get_current_scene().queue_free()
	elif body.is_in_group("Player") and scene_name == "Forest_level_2":
		LevelTransitions.change_scene_to("uid://dani6j2n6nwad")
		get_tree().get_current_scene().queue_free()
