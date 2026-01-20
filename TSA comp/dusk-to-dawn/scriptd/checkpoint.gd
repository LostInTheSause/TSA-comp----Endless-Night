extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D =  $"../Lil guy/%AnimatedSprite2D"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var rich_text_label: RichTextLabel = $RichTextLabel



signal respawn(is_true)
var checkpoint_activated = false
var checkpoint_position = 0
var animation_plaYED = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoint_position = self.global_position
	#lil_guy.is_dead.connect(on_death)
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._on_checkpoint_body_entered(checkpoint_activated)
		if !animation_plaYED:
			animation_player.play("checkpoint_reached")
			await animation_player.animation_finished
			rich_text_label.visible = false
			animation_plaYED = true
