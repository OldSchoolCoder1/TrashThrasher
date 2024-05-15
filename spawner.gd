extends Node2D

# Accessing the parent node directly as 'blaster' since 'spawner' is a child of 'Blaster'
@onready var blaster = get_parent()

@onready var projectile_scene = preload("res://Projectile.tscn")  # Make sure this path is correct

var OFFSET = 50  # Define OFFSET here, set to 50 pixels; adjust as needed for your game's needs

func _ready():
	# Check if 'blaster' is correctly assigned
	if blaster == null:
		print("Blaster node not found!")
	else:
		print("Blaster node found successfully.")

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()

func shoot():
	if not projectile_scene:
		print("Projectile scene not loaded")
		return

	var instance = projectile_scene.instance()
	instance.dir = rotation  # Assuming 'dir' is defined in your projectile script
	instance.spawnPos = global_position + Vector2(cos(rotation), sin(rotation)) * OFFSET
	instance.spawnRot = rotation
	blaster.add_child(instance)  # Ensure the projectile is added to the scene tree
