extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d: Area2D = $Area2D

var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		if player.get("dead") == true:
			await get_tree().create_timer(1.0).timeout
			animation_player.play("RESET")
			area_2d.monitoring = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animation_player.play("platform_crumble")
		player = body
		area_2d.monitoring = false
