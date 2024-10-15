extends Node2D

func _process(delta):
	if Global.bos_defeated == true:
		get_tree().change_scene_to_file("res://dzzy.gd")
