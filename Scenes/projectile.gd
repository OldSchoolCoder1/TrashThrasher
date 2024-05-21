extends CharacterBody2D
var speed := 800
var world
@export var explosion_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_parent().get_node("WorldContainer")

	var mouse = get_global_mouse_position()
	look_at(get_global_mouse_position())
	velocity = (mouse - position).normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if(position.distance_to(world.position) > 1300):
		queue_free()
	

func _physics_process(_delta):
	move_and_slide()

	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		if collision.get_collider().get_class() == "TrashObject":
			spawn_explosion()
			queue_free()
			collision.collider.queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Trash"):
		$"..".trash_count -= 1
		body.queue_free()
		spawn_explosion()
		queue_free()
	if body.is_in_group("Saucers"):
		body.hit()
		queue_free()

func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("Saucers"):
		area.hit()
		spawn_explosion()
		queue_free()

func spawn_explosion():
	var boom = explosion_scene.instantiate()
	boom.global_position = global_position
	boom.rotation = rotation
	boom.z_index = 10
	get_parent().get_parent().add_child(boom)
