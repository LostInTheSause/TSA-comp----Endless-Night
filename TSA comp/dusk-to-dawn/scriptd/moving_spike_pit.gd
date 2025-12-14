extends Node2D


@export var how_many_spikes_in_pit: int = 0

const spikes = preload("res://scenes/moving_spikes.tscn")
var move_amt = -35
var y_value= self.position.y
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if how_many_spikes_in_pit > 1:
		for i in range(how_many_spikes_in_pit):
			var new_spikes = spikes.instantiate()
			add_child(new_spikes)
			new_spikes.position = Vector2(i * move_amt, y_value)
			if i > 18:
				new_spikes.get_child(0).frame = i -18
			else:
				new_spikes.get_child(0).frame = i
