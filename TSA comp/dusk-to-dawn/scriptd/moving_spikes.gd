extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var kill_zone: Area2D = $kill_zone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("new_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animated_sprite_2d.frame >= 3 and animated_sprite_2d.frame <= 9:
		kill_zone.monitoring = false
	else:
		kill_zone.monitoring = true
