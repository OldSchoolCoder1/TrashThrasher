extends Node

var trash_count : int
var max_trash : int
var saucer_count : int
var max_saucers : int
var saucer_spawn_distance = 800
var enemies_to_win = 4
var kills = 0
@export var saucer_scene : PackedScene
signal lost

# Called when the node enters the scene tree for the first time.
func _ready():
	$TransitionScreen/ColorRect.color = Color(0, 0, 0, 0)
	max_trash = 100
	max_saucers = 8
	trash_count = 0
	saucer_count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	apply_pollution()
	if saucer_count < max_saucers:
		spawn_saucer()
	if kills >= enemies_to_win:
		win()
	if trash_count >= max_trash:
		lose()
	

func spawn_saucer():
	var new_saucer = saucer_scene.instantiate()
	var angle = randf_range(0, PI*2)
	var vec = Vector2.RIGHT.rotated(angle).normalized()
	new_saucer.position = $WorldContainer.position - (vec.normalized() * 900)
	add_child(new_saucer)
	saucer_count += 1
	
func win():
	max_saucers = 0
	for node in get_tree().get_nodes_in_group("Saucers"):
		node.queue_free()
	$Player/Timer.stop()
	$Player.can_shoot = false
	$Player/Boss.visible = true
	$AnimationPlayer.play("dramatic_boss_entrance")
	
	
func lose():
	#animate complete darkening of planet
	$TransitionScreen/AnimationPlayer.play("fade_to_black")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Level/LossScene.tscn")
	
func apply_pollution():
	$PollutionMask.self_modulate.a = (trash_count / max_trash) * 100 #percentage decimal here, delete pass line
	
	
func apply_saucer_death():
	saucer_count -= 1;
