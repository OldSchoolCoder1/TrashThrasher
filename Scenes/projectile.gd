extends CharacterBody2D
@export var speed := 10

# Called when the node enters the scene tree for the first time.
func _ready():
	var mouse = get_global_mouse_position()
	look_at(get_global_mouse_position())
	velocity = (mouse - position).normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func _physics_process(_delta):
	move_and_slide()
