extends Node2D
@onready var node_2d: Node2D = $Node2D/Node2D
@onready var shooting_star: AnimatedSprite2D = $Node2D/Node2D/shooting_star


@onready var camera_2d: Camera2D = $Camera2D
@onready var animation_player: AnimationPlayer = $Node2D/Node2D/shooting_star/AnimationPlayer

var starting_pos = Vector2(0.0, -43.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_2d.position = starting_pos
	Dialogic.start("opening_imeline")
	Dialogic.signal_event.connect(on_dialogic_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func  on_dialogic_signal(argument: String) -> void:
	if argument == "make_star_shoot":
		node_2d.visible = true
		shooting_star.play("shoot_star")
		animation_player.play("flying_star")
		animation_player.animation_finished.connect(star_shooting_done)
	elif argument == "show_title":
		pass
		
func star_shooting_done() -> void:
	node_2d.visible = false
