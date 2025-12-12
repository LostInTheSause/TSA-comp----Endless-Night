extends Node2D
@onready var sprite: Sprite2D = $Sprite2D

var tween = create_tween()

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_properties( player_frame, player_scale, player_modulate, show_behind=false):
	
	sprite.frame = player_frame
	sprite.scale = player_scale
	sprite.modulate = player_modulate
	sprite.show_behind_parent = show_behind
	fade_out()

func fade_out():
	# Fade the ghost out by animating its alpha (self_modulate)
	tween.tween_property(sprite, "self_modulate:a", 0.0, 0.15) # 0.45 is the fade duration
	tween.tween_callback(queue_free)
	
