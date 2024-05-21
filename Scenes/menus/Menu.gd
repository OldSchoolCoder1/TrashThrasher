extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level/Level.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/menus/options.tscn")


func _on_help_pressed():
	get_tree().change_scene_to_file("res://Scenes/menus/help.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/menus/credits.tscn")


func _on_quit_pressed():
	get_tree().quit()

