extends Node2D

@onready var blaster = get_node("../Blaster")  # Adjust the path to correctly reference the Blaster node
@onready var projectile_scene = preload("res://Projectile.tscn") 

var OFFSET = 50 

func _ready():
	
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()

func shoot():
	if not projectile_scene:
		print("Projectile scene not loaded")
		return

	var instance = projectile_scene.instance()
	instance.dir = rotation  
	instance.spawnPos = global_position + Vector2(cos(rotation), sin(rotation)) * OFFSET
	instance.spawnRot = rotation
	blaster.add_child(instance)
