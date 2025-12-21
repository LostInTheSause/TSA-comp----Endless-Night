extends Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"Lil guy/AudioStreamPlayer2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player_2d.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hi")
	if body.is_in_group("player"):
		LevelTransitions.change_scene_to("uid://bguqgq5hmp3td")


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("hi")
	
	LevelTransitions.change_scene_to("uid://bguqgq5hmp3td")
