extends Area2D

var Trash = preload("res://Scenes/TrashObject.tscn")
# Properties
var health = 3
var speed = 100
var direction = Vector2()
@export var sprite: AnimatedSprite2D
var collision_shape: CollisionShape2D
@export var trash : PackedScene
@export var trash_time := 1
var timer = 0
var world : Node2D
var planet_normal : Vector2
# var damage_sound = preload("res://sounds/damage.wav")  # ADd sound if wanted

func _ready():
	world = $"..//WorldContainer"
	add_to_group("Saucers")
	collision_shape = self.get_node("CollisionShape2D")
	randomize()
	direction = Vector2(randf() * 2.0 - 1.0, randf() * 2.0 - 1.0).normalized()

	# Assuming collision detection is setup, connect signal here
#     connect("body_entered", self, "_on_FlyingSaucer_body_entered")

func _process(delta):
	planet_normal = (global_position - world.global_position).normalized()
	check_bounds()
	position += direction * speed * delta
	rotation = planet_normal.angle() + PI/2
	if randf() * 100 > 99:
		direction = Vector2(randf() * 2.0 - 1.0, randf() * 2.0 - 1.0).normalized()
	update_animation()
	timer += delta
	if timer >= trash_time:
		timer = 0
		spawn_trash()

# Function to spawn trash
func spawn_trash():

	var new_trash = trash.instantiate()
	new_trash.position = position
	new_trash.add_to_group("Trash")
	get_parent().add_child(new_trash)

 # Function to take damage func take_damage(amount):
func take_damage(amount):
	health -= amount
	if health <= 0:
		die()
		play_sound()
		update_animation()

# Function to handle the saucer's destruction
func die():
	queue_free()  # Removes the node from the scene

# Play sound effects
func play_sound():
	var player = AudioStreamPlayer.new()
	# player.stream = damage_sound
	add_child(player)
	player.play()
	# player.connect("finished", player, "queue_free")

# Check if the saucer is within screen bounds
func check_bounds():
	print(position.distance_to(world.position))
	if position.distance_to(world.position) > 1050:
		direction = -planet_normal
	if position.distance_to(world.position) < 800:
		direction = planet_normal
		

# Update sprite animation based on the saucer's state
func update_animation():
	if health < 50:
		sprite.play("damaged")
	else:
		sprite.play("normal")

func hit():
	health -= 1
	if health <= 0:
		queue_free()
