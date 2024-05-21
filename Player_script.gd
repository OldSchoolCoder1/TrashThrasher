extends CharacterBody2D

@export var SPEED = 100
const SHOOT_SPEED = 500
@export var grav_strength = 75
@export var jump = 700
var can_shoot = true
@export var proj_scene : PackedScene
@export var world: Node2D
var planet_normal : Vector2
var local_velocity : Vector2

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

func _ready():
	wall_min_slide_angle = 0
	
func _process(delta):
	check_shoot()
	move_player(delta)


func _physics_process(_delta):
				
	gravity_direction = (position - world.position).normalized()
	up_direction = gravity_direction
	velocity -= (gravity_direction.normalized() * grav_strength)

	move_and_slide()
	

func move_player(_delta):
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = SPEED * horizontal_direction
	
	if horizontal_direction !=0:
		sprite.flip_h = (horizontal_direction == -1)
	
	update_animations(horizontal_direction)	

	# Handle movement with arrow keys or A/D keys
	if Input.is_action_pressed("move_left"):
		if rotation >= (-PI / 2) and rotation <= (PI / 2):
			velocity.x = SPEED * horizontal_direction
 
	if Input.is_action_pressed("move_right"):
		if rotation >= (-PI / 2) and rotation <= (PI / 2):
			velocity.x = SPEED * horizontal_direction

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity += gravity_direction * jump
		

func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("Idle")
		else:
			if horizontal_direction != 0:
				ap.play("Run")
	else:
		if velocity.y < 0:
			ap.play("Jump")
		

func check_shoot():
	if Input.is_action_just_pressed("shoot") and can_shoot:
		var projectile = proj_scene.instantiate()
		projectile.position = position
		add_sibling(projectile)
		can_shoot = false
		$Timer.start()  # Start cooldown timer for shooting

func _on_timer_timeout():
	can_shoot = true
