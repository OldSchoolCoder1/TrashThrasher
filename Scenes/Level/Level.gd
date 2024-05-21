extends Node

var trash_count : int
var max_trash : int
var saucer_count : int
var max_saucers : int
var saucer_spawn_distance = 800
@export var saucer : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	max_trash = 600
	max_saucers = 3
	trash_count = 0
	saucer_count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if saucer_count < max_saucers:
		spawn_saucer()

func spawn_saucer():
	var new_saucer = saucer.instantiate()
	var angle = randf_range(0, PI*2)
	var vec = Vector2.RIGHT.rotated(angle).normalized()
	new_saucer.position = $WorldContainer.position - (vec.normalized() * 900)
	add_child(new_saucer)
	saucer_count += 1
	
func win():
	pass
	
func lose():
	pass
	
func apply_pollution():
	pass
	
func apply_saucer_death():
	saucer_count -= 1;

	
