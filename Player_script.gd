extends CharacterBody2D

@export var SPEED = 150
const JUMP_VELOCITY = -200
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
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	if horizontal_direction:
		local_velocity.x = horizontal_direction * SPEED
		sprite.flip_h = (horizontal_direction == -1)
	else:
		local_velocity.x = move_toward(local_velocity.x, 0, SPEED)
		
	velocity = local_velocity.rotated(rotation)
	if Input.is_action_pressed("jump") and is_on_floor():
		local_velocity.y = JUMP_VELOCITY
	update_animations(horizontal_direction)
		
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
