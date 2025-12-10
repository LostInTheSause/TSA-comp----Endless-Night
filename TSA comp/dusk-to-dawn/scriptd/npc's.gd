extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $"Npc charecter Body/AnimatedSprite2D"
@onready var prespeak_label: RichTextLabel = $"Npc charecter Body/AnimatedSprite2D/prespeak_Label"
@onready var area_2d: Area2D = $"Npc charecter Body/Area2D"
@onready var npc_charecter_body: CharacterBody2D = $"Npc charecter Body"


@onready var lil_guy: CharacterBody2D = $"../Lil guy"
@onready var camera_2d: Camera2D = %Camera2D



@export var NPC_idle_animation: SpriteFrames 
@export var NPC_talking_animation: bool = false
var can_talk = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prespeak_label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_talk:
		if Input.is_action_pressed("talk"):
				lil_guy.is_talking = true
				Dialogic.start("opening_imeline")
				
				Dialogic.timeline_ended.connect(done_talking)
				


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_talk = true
		prespeak_label.show()
		#body.is_talking = true
			
			
			
			

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == lil_guy:
		prespeak_label.hide()
		can_talk = false

func done_talking() -> void:
	lil_guy.is_talking = false
