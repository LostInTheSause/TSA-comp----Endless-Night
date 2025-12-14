extends Node2D
@onready var node_2d: Node2D = $Node2D/Node2D
@onready var shooting_star: AnimatedSprite2D = $Node2D/Node2D/shooting_star
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var button: Button = $Button

@onready var camera_2d: Camera2D = $Camera2D
@onready var animation_player: AnimationPlayer = $Node2D/Node2D/shooting_star/AnimationPlayer

@onready var fire: AnimatedSprite2D = $Node2D/floor/fire
@onready var animated_sprite_2d: AnimatedSprite2D = $Node2D/floor/AnimatedSprite2D

@onready var cloud_1: Sprite2D = $Node2D/cloud1
@onready var cloud_2: Sprite2D = $Node2D/cloud2
@onready var cloud_3: Sprite2D = $Node2D/cloud3
@onready var cloud_4: Sprite2D = $Node2D/cloud4
@onready var player_v_3_idol_right: Sprite2D = $Node2D/floor/PlayerV3IdolRight



var starting_pos = Vector2(0.0, -43.0)
var pan_up = false
var button_in = false
var button_amt = 0.1
var first_half_done = false
var pan_down = false

var clouds_move = true

var up_clouds_move_amt = 30
var down_clouds_move_amt = 45


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
	if first_half_done:
		if clouds_move:
			cloud_1.position.x -= down_clouds_move_amt * delta
			cloud_2.position.x += up_clouds_move_amt * delta
			cloud_3.position.x -= up_clouds_move_amt * delta
			cloud_4.position.x += down_clouds_move_amt * delta
		if pan_down:
			camera_2d.position = starting_pos
			starting_pos.y += 20 * delta
			if starting_pos.y >= -43:
				pan_down = false
				Dialogic.start("opening_timeline_part2")




func  on_dialogic_signal(argument: String) -> void:
	if argument == "make_star_shoot":
		node_2d.visible = true
		shooting_star.play("shoot_star")
		animation_player.play("flying_star")
		await animation_player.animation_finished
		node_2d.visible = false
	elif argument == "Show_title":
		pan_up = true
	elif argument == "look_around":
		animation_player.play("lookaround")
	elif argument == "start_gameplay":
		LevelTransitions.change_scene_to("uid://dani6j2n6nwad")
		
func star_shooting_done() -> void:
	node_2d.visible = false


func _on_button_pressed() -> void:
	first_half_done = true
	animated_sprite_2d.visible = false
	fire.play("fire_out")
	player_v_3_idol_right.visible = true
	pan_down= true
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	clouds_move = false
