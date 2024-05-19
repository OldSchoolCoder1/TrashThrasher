extends CharacterBody2D

@export var SPEED = 100
const SHOOT_SPEED = 500
var grav_strength = 75
var jump = 700
var can_shoot = true
var projectile_scene = preload("res://Projectile.tscn")
@export var world: Node2D
var gravity_direction

func _ready():
	wall_min_slide_angle = 0
	
func _process(delta):
	rotate(get_angle_to(world.global_position) - PI/2)
	move_player(delta)
	print(up_direction)

func _physics_process(delta):
	gravity_direction = (position - world.position).normalized()
	up_direction = gravity_direction
	velocity -= (gravity_direction.normalized() * grav_strength)
	move_and_slide()
	

func move_player(delta):
	# Handle movement with arrow keys or A/D keys
	velocity.x = 0
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		if rotation >= (-PI / 2) and rotation <= (PI / 2):
			velocity.x = -SPEED
		else:
			velocity.x = SPEED
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		if rotation >= (-PI / 2) and rotation <= (PI / 2):
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity += gravity_direction * jump

func check_shoot():
	pass
	#if Input.is_action_just_pressed("shoot") and can_shoot:
		#var projectile = projectile_scene.instance()
		#get_parent().add_child(projectile)
		#projectile.position = position
		#projectile.velocity = Vector2(0, -SHOOT_SPEED)
		#can_shoot = false
		#$Timer.start()  # Start cooldown timer for shooting

func _on_Timer_timeout():
	can_shoot = true
