extends Control


@onready var charecter_name: Label = $background/Name
@onready var face: TextureRect = $background/face
@onready var what_they_have_to_say: Label = $"background/what they have to say"

@export var the_name: String = ""
@export var charecter_face = Image
@export var text: String = ""
@export var speaks_more_then_once: bool = false





# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
