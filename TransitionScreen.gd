extends CanvasLayer

signal transitioned

func transition():
	$AnimationPlayer.play("fade_to_black")

func _on_AnimationPlayer_animation_finished(anim_name):
		emit_signal("transitioned")
