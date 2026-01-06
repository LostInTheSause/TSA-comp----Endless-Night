extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flicker()



	

func flicker() -> void:
	self.energy = randf_range(2.0,7.0)
	await get_tree().create_timer(0.07).timeout
	flicker()
