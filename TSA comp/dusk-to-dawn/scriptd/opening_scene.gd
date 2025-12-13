extends Node2D
@onready var node_2d: Node2D = $Node2D/Node2D
@onready var shooting_star: AnimatedSprite2D = $Node2D/Node2D/shooting_star
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var button: Button = $Button

@onready var camera_2d: Camera2D = $Camera2D
@onready var animation_player: AnimationPlayer = $Node2D/Node2D/shooting_star/AnimationPlayer

var starting_pos = Vector2(0.0, -43.0)
var pan_up = false
var button_in = false
var button_amt = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_2d.position = starting_pos
	Dialogic.start("opening_imeline")
	Dialogic.signal_event.connect(on_dialogic_signal)
	audio_stream_player_2d.playing = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pan_up:
		camera_2d.position = starting_pos
		starting_pos.y -= 10 * delta
		if starting_pos.y <= -207.0:
			pan_up = false
			button_in = true
	if button_in:
		button.visible = true


func  on_dialogic_signal(argument: String) -> void:
	if argument == "make_star_shoot":
		node_2d.visible = true
		shooting_star.play("shoot_star")
		animation_player.play("flying_star")
		await animation_player.animation_finished
		node_2d.visible = false
	elif argument == "Show_title":
		pan_up = true
		
func star_shooting_done() -> void:
	node_2d.visible = false


func _on_button_pressed() -> void:
	
	LevelTransitions.change_scene_to("uid://bg1n544f7hdek")
