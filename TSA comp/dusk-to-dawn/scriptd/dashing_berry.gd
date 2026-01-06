extends Node2D

const dash_speed = 400
@onready var animation_player: AnimationPlayer = $Berry/AnimationPlayer
@onready var area_2d: Area2D = $Berry/Area2D

var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player && player.get("dead") == true:
		await get_tree().create_timer(1.1).timeout
		animation_player.play("RESET")
		area_2d.monitoring = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var direction = Input.get_axis("left","right")
		body.hit_berry = true
		animation_player.play("berry gone")
		player = body
		area_2d.monitoring = false
