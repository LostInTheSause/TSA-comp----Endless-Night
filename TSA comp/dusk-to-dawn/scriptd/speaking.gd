
extends Control

@onready var charecter_name: Label = $background/Charecter_Name


@onready var face: TextureRect = $background/face

@onready var what_they_have_to_say: RichTextLabel = $"background/what they have to say"


@export var seen_before = false


@export_category("text opitions")
@export var NPCs_name: String = "???"
@export var charecter_face = Image
@export var inital_text: String = ""
@export var speaks_more_then_once: bool = false
@export var all_text: PackedStringArray


@export_category("typing effects")
@export var scared: bool = false
@export var typing_speed: float = 0.1


var current_char: int = 0
var time_elapsed: float = 0

# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	self.hide()
	face.texture = charecter_face
	if not seen_before:
		charecter_name.text = "???"
		seen_before = true
	else:
		charecter_name.text = NPCs_name
	what_they_have_to_say.text = inital_text
	what_they_have_to_say.visible_characters = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func typing_text(speed: float, is_scared: bool, delta: float) -> void:
	
	
	
	if current_char < what_they_have_to_say.length():
		time_elapsed += delta
		current_char = int(time_elapsed / speed)
	
	# Ensure current_char doesn't exceed the text length
		if current_char > what_they_have_to_say.length():
			current_char = what_they_have_to_say.length()
	
		self.visible_characters = current_char
	if is_scared:
		what_they_have_to_say.text = str("[shake]" + inital_text + "[/shake]")
		
		
func aditional_text(speed: float, is_scared: bool, delta: float) -> void:
	pass
