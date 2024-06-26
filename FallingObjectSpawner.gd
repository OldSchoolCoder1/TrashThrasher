extends Node2D

@export var SPAWN_INTERVAL = 1.5
var time_since_last_spawn = 0

var falling_object_scene = preload("res://Scenes/TrashObject.tscn")

func _process(_delta):
	time_since_last_spawn += _delta

	# Check if it's time to spawn a new object
	if time_since_last_spawn >= SPAWN_INTERVAL:
		spawn_object()
		time_since_last_spawn = 0

func spawn_object():
	# Instantiate a new falling object and add it to the scene
	var new_object = falling_object_scene.instantiate()
	var rot_degrees = randf_range(0, 359)
	new_object.rotation = rot_degrees
	get_parent().get_node("WorldContainer").add_child(new_object)
	var width = get_tree().get_root().get_viewport().get_visible_rect().size.x
	new_object.global_position.x = randf_range(-width, width*2)  # Randomize x position
	new_object.global_position.y = -10  # Start above the screen.
