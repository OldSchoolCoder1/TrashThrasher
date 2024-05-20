extends Node2D

@onready var blaster = get_tree().get_root().get_node("Blaster")
@onready var projectile = load("res://assets/player/laser-blast1.png") 

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot()


func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	blaster.add_child(instance)
