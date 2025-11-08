extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D =  $"../Lil guy/%AnimatedSprite2D"



@onready var lil_guy: CharacterBody2D = $"../Lil guy"

signal respawn(is_true)
var checkpoint_activated = false
var checkpoint_position = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoint_position = self.global_position
	#lil_guy.is_dead.connect(on_death)

# Called every frame. 'delta' is the elapsed time since the previous fra

func _on_area_2d_area_entered(_area: Area2D) -> void:
	emit_signal("respawn", checkpoint_position)
	
