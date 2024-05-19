extends Node2D
@export var speed := 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y=position.y-speed*delta
	#Check out of bounds, delete if so
	if position.y < -20:
		queue_free()
