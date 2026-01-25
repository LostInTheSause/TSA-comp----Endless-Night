extends CharacterBody2D




	

@onready var animated_sprite_2d = $AnimatedSprite2D
var moving = true
var time_to_float = 0.5
var time = 0.0
var float_end = false
const ghost_speed = 150
var show_ghost = false
var wait_for_input = true
var can_move = true
var teleport = false
func _physics_process(delta: float) -> void:
	if show_ghost:
		ghost_ani(delta)
	else:
		
		can_move = false
		time = 0.0
		wait_for_input = true
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("dash") - Input.get_action_strength("jump")
	).normalized()
	
	if direction.x > 0:
		animated_sprite_2d.flip_h = true
	elif direction.x < 0:
		animated_sprite_2d.flip_h = false
	
	if can_move:
		velocity = direction * ghost_speed
		moving = true
	else:
		velocity.x = move_toward(velocity.x,0,ghost_speed)
		velocity.y = move_toward(velocity.y,0,ghost_speed)
		animated_sprite_2d.play("brefore_move")
		moving = false
	
	move_and_slide()

func ghost_ani(delta) -> void:
	
	can_move = true
	visible = true
	await get_tree().create_timer(0.1).timeout
	if Input.is_anything_pressed() and wait_for_input:
		wait_for_input = false
		animated_sprite_2d.play("start_float")
		await animated_sprite_2d.animation_finished 
		time += delta
		
		
	elif float_end:
		time= 0.0
		can_move = false
		float_end = false
		animated_sprite_2d.play("end_float")
		await animated_sprite_2d.animation_finished
		teleport = true
		visible = false
		show_ghost = false
		
		wait_for_input = true
		
	elif !wait_for_input and time != 0.0:
		if moving:
			animated_sprite_2d.play("float")
		else:
			animated_sprite_2d.play("brefore_move")
		time += delta
	elif wait_for_input:
		animated_sprite_2d.play("brefore_move")
		
	if time > time_to_float:
		float_end = true
	
