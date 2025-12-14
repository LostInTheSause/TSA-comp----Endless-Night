extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var lil_guy: CharacterBody2D = $"../Lil guy"


const bounce_velocity: int = 600
const bounce_direction: Vector2 = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animated_sprite_2d.play("bounce_animation")
	

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		while !animated_sprite_2d.animation_finished:
			pass
		animated_sprite_2d.stop()
			
		


func _on_bounce_player_body_entered(body: Node2D) -> void:
	if body.get("Mushroom_jump_amt"):
		body.velocity.y = -body.Mushroom_jump_amt
		body.show_dust = false
