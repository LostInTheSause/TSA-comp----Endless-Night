extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var kill_zone: Area2D = $"kill zone"


@onready var checkpoint: Area2D = $"../checkpoint"
@onready var dash_timer: Timer = $"dash timer"
@onready var ghost_timer: Timer = $ghost_timer
@onready var dashing_arrow: Node2D = $"dashing arrow"





var SPEED = 0
const run_speed = 220
@export var walk_SPEED = 100

const dash_velo = 500
var dash_time = 0.2
var is_dashing = false
var dash_available = true
@export var ghost_scene: PackedScene

var Jump_velo = -300.0
const JUMP_VELOCITY = -300.0
const RUNNING_JUMP = -350


var jump_buffer = false
@export var jump_buffer_timer = 0.4

@export var coyote_time = 0.3
var jump_availabel = true


var running = false

const max_stamina = 100
const min_stamina = 0
var stamina_lose_rate = 50
var current_stamina = 100
var stamina_regen_rate = 20

#varables for the players death

var dead = false
var max_hearts = 5
var cur_hearts = 5
var respawn_point = 0


func _ready() -> void:
	respawn_point = self.global_position
	
	kill_zone.death.connect(self._on_kill_zone_body_entered)
	checkpoint.respawn.connect(self._on_checkpoint_body_entered)
	
	



func _physics_process(delta: float) -> void:
	
	
	
		
	if dead:
		#animated_sprite_2d.play("death")
		_on_death()
		
	else:
	#handles what happends if the charecter is running
		if Input.is_action_pressed("run"):
			#if current_stamina > min_stamina:
			current_stamina -= stamina_lose_rate*delta
			if current_stamina > min_stamina:
				SPEED = run_speed
				running = true
				Jump_velo = RUNNING_JUMP
			else:
				SPEED = walk_SPEED
				running = false
				Jump_velo = JUMP_VELOCITY
		else:
			#if current_stamina <= min_stamina:
			SPEED = walk_SPEED
			running = false
			Jump_velo = JUMP_VELOCITY
		
			current_stamina += stamina_regen_rate * delta
			
		
		
		current_stamina = clamp(current_stamina, 0, max_stamina)
		# Add the gravity.
		#
		#handles coyote time
		if not is_on_floor(): 
			if jump_availabel:
				get_tree().create_timer(coyote_time).timeout.connect(coyote_timeout)
				
			
			velocity += get_gravity() * delta
		else:
			jump_availabel = true
			dash_available = true
		# Handle jump.
		if Input.is_action_just_pressed("jump") and jump_availabel and is_on_floor():
			jump()
		elif Input.is_action_just_pressed("jump"):
			#handles jump buffering so if the player inputs a jump to early to re_jump they can still jump making it feel better to play
			jump_buffer = true
			get_tree().create_timer(jump_buffer_timer).timeout.connect(_on_jump_buufer_of_doom_timeout)
			if jump_availabel and jump_buffer:
				jump()
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left", "right")
		
		
		#flips the sprite to face the direction it is moving
		if direction < 0:
			animated_sprite_2d.flip_h = true
		elif direction > 0:
			animated_sprite_2d.flip_h = false
		
		if Input.is_action_just_pressed("dash") and not is_dashing and dash_available:
			
			pre_dash()
			
		if direction:
			
			if running:
				velocity.x = direction * SPEED
				animated_sprite_2d.play("runniing")
			else:
				velocity.x = direction * SPEED
				animated_sprite_2d.play("walking")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite_2d.play("idle")
		
		if is_dashing and ghost_timer.is_stopped():
			create_ghost()
			ghost_timer.start() # Reset the timer


		move_and_slide()


func when_player_leave_screen() -> void:
	if not self.position.y > camera_2d.limit_bottom:
		camera_2d.position = self.position
	

func coyote_timeout():
	jump_availabel = false

func jump() -> void:
	velocity.y = Jump_velo
	animated_sprite_2d.play("jumping(temp)")
	jump_availabel = false
	cur_hearts -= 1

func _on_jump_buufer_of_doom_timeout() -> void:
	jump_buffer = false
	


func _on_checkpoint_body_entered(checkpoint_position) :

	respawn_point = self.global_position
	print(respawn_point)
		
		
func _on_death() -> void:
	
	dead= false
	set_collision_mask_value(1, false) # Example: disable collision with layer 1
	
	await get_tree().create_timer(1.0).timeout
	respawn()
	
	
func respawn() -> void:
	dead = false
	respawn_point.y -= 20
	self.position = respawn_point
	
	animated_sprite_2d.play("idle")
	set_collision_mask_value(1, true) # Re-enable collision
	camera_2d.position = self.position
	current_stamina = 100

func _on_kill_zone_body_entered(_is_dead):
	
		dead = true


func doing_the_dash(x,y):
	
	
	velocity = -Vector2(x + self.velocity.x, y + self.velocity.y )
	dash_timer.start()
	is_dashing = true
	create_ghost()

func _on_dash_timer_timeout() -> void:
	
	
	stop_dash()

func pre_dash() -> void:
	dashing_arrow.rotation_degrees = 0.0
	dashing_arrow.look_at(get_global_mouse_position())
	
	var angle_of_movement = dashing_arrow.rotation
	angle_of_movement = sqrt(angle_of_movement**2)	
	var bottom_unit = 0.0
	var angle = 0
	
	var vertical_movement =  0
	for i in range(360,22.5,45):
		if bottom_unit < angle_of_movement < i:
			angle_of_movement = angle
			
		else:
			bottom_unit = i
			angle += 45
	
	dashing_arrow.rotation = angle
	var horizontal_movment = -deg_to_rad(self.position.x + dash_velo*(cos(angle_of_movement)))*80
	
	
	
	vertical_movement = deg_to_rad(self.position.y + dash_velo*(sin(angle_of_movement)))*60
	
	
	doing_the_dash(horizontal_movment,vertical_movement)
	dash_available = false




func stop_dash():
	is_dashing = false
		# Reset velocity to normal speed in the current direction
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
		# This is important to prevent sliding when the dash ends
	if direction == 0:
		velocity.x = 0
	
func create_ghost():
	if ghost_scene:
		var new_ghost = ghost_scene.instantiate()
		get_parent().add_child(new_ghost)
		new_ghost.set_properties(
			animated_sprite_2d.frame,    # The current animation frame
			animated_sprite_2d.scale,
			animated_sprite_2d.self_modulate,
			true # Set to true if you want the ghost behind the player
		)
		new_ghost.global_position = global_position
