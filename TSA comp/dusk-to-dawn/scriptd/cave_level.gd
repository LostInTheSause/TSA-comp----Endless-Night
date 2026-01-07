extends Node2D

@onready var torch: AnimatedSprite2D = $torch
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

var player: CharacterBody2D
var color_rect_tween: Tween
var move_charles = false
var stop_chalres = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(on_dialogic_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move_charles:
		animated_sprite_2d.position.x += 100*delta
		stop_chalres += delta
		if stop_chalres >= 1:
			move_charles = false


func _on_start_texttrunghost_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.falling = false
		body.is_ghost = true 
		Dialogic.start("cavetimeline")


func _on_falling_animaiton_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		body.falling = true
		body.emit_particles = false
		
func on_dialogic_signal(argument: String) -> void:
	if argument == "show_charles":
		torch.visible = true
		animated_sprite_2d.visible = true
		await get_tree().create_timer(1.0).timeout
		move_charles = true
	elif argument == "close":
		color_rect_tween = create_tween().set_trans(Tween.TRANS_SINE)
		color_rect_tween.tween_property(color_rect, "modulate:a", 1.0, 1.5)
		
