extends Camera2D

var player: CharacterBody2D
var past_dead_zone = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		if past_dead_zone:
			self.position = player.position
		if player.get("moving") == false:
			past_dead_zone = false
	


func _on_camera_dead_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		past_dead_zone = true
		player = body
