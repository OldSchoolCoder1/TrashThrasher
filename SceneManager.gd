extends Node2D

const loss = preload("res://Scenes/Level/LossScene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_lost():
	$TransitionScreen.transition()
	



func _on_transition_screen_transitioned():
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(loss.instantiate())
