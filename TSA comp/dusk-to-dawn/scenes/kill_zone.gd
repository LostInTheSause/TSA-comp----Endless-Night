extends Node2D


signal death(is_dead)
var is_dtead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	
	emit_signal("death", is_dtead)
