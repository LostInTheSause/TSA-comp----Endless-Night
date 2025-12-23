extends Node2D


func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_rope_position(body):
	var newPositon: Vector2 
	var shortestDistance = false
	for child in get_children():
		if not child is Sprite2D: continue
		
		var distance = body.global_position.distance_to(child.global_position)
		
		if not shortestDistance or distance < shortestDistance:
			newPositon = child.global_position
			shortestDistance = distance
			
	return newPositon
