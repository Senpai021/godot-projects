extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound = $jump_sound

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const DOUBLE_JUMP_VELOCITY = JUMP_VELOCITY / 2

#jump count
var jump_count = 0
const MAX_JUMPS = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	DisplayServer.window_set_title("Knight Adventure")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle jump and doublejump.
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		print(jump_count)
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
		jump_count += 1
		if jump_count == MAX_JUMPS:
			velocity.y = DOUBLE_JUMP_VELOCITY
		
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Play animations
	if is_on_floor():
		jump_count = 0
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	#Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
func getJumps():
	return jump_count
