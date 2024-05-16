extends Node2D
@onready var projectile = preload("res://Scenes/projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var instance= projectile.instantiate()
		add_child(instance)
		instance.position=Vector2(0,0)
