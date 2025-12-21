extends Node2D

@onready var animated_sprite_2d: Sprite2D = $Node2D/AnimatedSprite2D

@onready var marker_2d: Marker2D = $Marker2D

@onready var node_2d: Node2D = $Node2D

# Called when the node enters the scene tree for the first time.
var player = CharacterBody2D
var on_vine = false

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_vine:
		player.position = marker_2d.position
		player.rotation = node_2d.rotation


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hi")
	if body.is_in_group("Player"):
		on_vine = true
		#marker_2d.position = body.position
		body.visible = true
		player = body
