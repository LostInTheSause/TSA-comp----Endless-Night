extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



const bounce_velocity: int = 600
const bounce_direction: Vector2 = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.get("dead") != true:
		animated_sprite_2d.play("bounce_animation")
	

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and body.get("dead") != true:
		while !animated_sprite_2d.animation_finished:
			pass
		animated_sprite_2d.stop()
			
		


func _on_bounce_player_body_entered(body: Node2D) -> void:
	if body.get("Mushroom_jump_amt") and body.get("dead") != true:
		body.velocity.y = -body.Mushroom_jump_amt
		body.show_dust = false
