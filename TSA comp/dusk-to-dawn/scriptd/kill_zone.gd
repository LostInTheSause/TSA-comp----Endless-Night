extends Node2D



signal death(is_dead)
var is_dtead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
	



	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if not is_dtead and not body.get("dead"):
			is_dtead = true
			body._on_death(is_dtead)
			await get_tree().create_timer(1.7).timeout
			is_dtead = false
