extends CharacterBody2D

const SPEED = 300
const SHOOT_SPEED = 500
var can_shoot = true
var projectile_scene = preload("res://Projectile.tscn")

func _process(delta):
	move_player(delta)
	check_shoot()

<<<<<<< Updated upstream
func move_player(delta):
	var direction = 0
=======
func _physics_process(_delta):
	gravity_direction = (position - world.position).normalized()
	up_direction = gravity_direction
	velocity -= (gravity_direction.normalized() * grav_strength)
	move_and_slide()
	
	
	

func move_player(_delta):
>>>>>>> Stashed changes
	# Handle movement with arrow keys or A/D keys
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		direction += 1
	move_and_slide(Vector2(direction * SPEED * delta, 0))

func check_shoot():
	if Input.is_action_just_pressed("shoot") and can_shoot:
		var projectile = projectile_scene.instance()
		get_parent().add_child(projectile)
		projectile.position = position
		projectile.velocity = Vector2(0, -SHOOT_SPEED)
		can_shoot = false
		$Timer.start()  # Start cooldown timer for shooting

func _on_Timer_timeout():
	can_shoot = true
