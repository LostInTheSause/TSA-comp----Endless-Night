extends Node2D

@onready var intro_to_ghost: Node2D = $"../GUI/intro_to_ghost"
var fade_gui: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await get_tree().create_timer(1.8).timeout
		fade_gui = create_tween().set_trans(Tween.TRANS_SINE)
		fade_gui.tween_property(intro_to_ghost, "modulate:a", 1.0, 0.4)
		


func _on_death_in_ghost_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._on_death(12)


func _on_end_level_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
