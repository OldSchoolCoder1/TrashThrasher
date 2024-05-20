#extends CharacterBody2D
#
#@export var SPEED = 100
#
#var vector : Vector2
#var pos : Vector2
#
#func Projectile(dir, pos):
	#vector = dir
	#
#
#func _ready():
	#pass
#
#func _physics_process(delta):
	#velocity = Vector2(0, -SPEED).rotated(dir)
	#move_and_slide()
