extends Node2D
@onready var projectile = preload("res://Scenes/projectile.tscn")

# properties
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and can_shoot:
		can_shoot = false
		var instance = projectile.instantiate()
		add_child(instance)
		instance.position = Vector2(0,0)
		
		# start timer and connect timeout signal to re-enable shooting
		var timer = get_node("Timer")
		timer.start()
		timer.timeout.connect(_on_Timer_timeout)

func _on_Timer_timeout():
	can_shoot = true
