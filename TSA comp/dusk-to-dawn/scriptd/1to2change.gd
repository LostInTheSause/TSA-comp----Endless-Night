extends Area2D

var transition_num = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player")   :
		LevelTransitions.change_scene_to("uid://dani6j2n6nwad")
	elif body.is_in_group("Player"):
		LevelTransitions.change_scene_to("uid://bguqgq5hmp3td")
