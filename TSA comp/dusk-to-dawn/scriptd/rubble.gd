extends Node2D

@export var duplicate := false
@export var in_x_direction: int = 0
@export var in_y_direction: int = 0
var move_distance = 80
const rubble = preload("res://scenes/rubble.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		
	for i in range(in_x_direction):
		var more_rubble = rubble.instantiate()
		add_child(more_rubble)
		more_rubble.position = Vector2.ZERO
		more_rubble.position.x = i*move_distance
		vertical_growth(more_rubble.position.x)
			
				
func vertical_growth(x_pos) -> void:
	if in_y_direction > 0:
		for j in range(in_y_direction):
				var vert_rubble = rubble.instantiate()
				add_child(vert_rubble)
				vert_rubble.position = Vector2.ZERO
				vert_rubble.position.x = x_pos
				vert_rubble.position.y +=  j*-move_distance 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
