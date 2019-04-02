extends KinematicBody2D

const GRAVITY = 37
const MAX_GRAVITY = GRAVITY * 40
const MAX_WALL_GRAVITY = GRAVITY * 4

const HORIZONTAL_SPEED = 400
const JUMP_VELOCITY = 637

const UP = Vector2(0, -1)

var motion = Vector2()

var jumps_remaining = 2
var direction = 1

func _physics_process(delta):
	var max_grav = MAX_GRAVITY
	if (is_on_wall()):
		max_grav = MAX_WALL_GRAVITY
	
	if (motion.y < max_grav):
		motion.y += GRAVITY
	else:
		motion.y = max_grav
	
	if (is_on_floor()):
		jumps_remaining = 1
	
		if (is_on_wall()):
			direction *= -1
	
		
	if (Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_tap")):
		jump()
	
	motion.x = direction * HORIZONTAL_SPEED
	
	motion = move_and_slide(motion, UP)
	
	
	
func jump():
	if (is_on_floor()):
		motion.y = -JUMP_VELOCITY
	elif (jumps_remaining > 0 && !is_on_wall()):
		jumps_remaining -= 1
		motion.y = -JUMP_VELOCITY
	elif (is_on_wall()):
		jumps_remaining = 1
		direction *= -1
		motion.y = -JUMP_VELOCITY