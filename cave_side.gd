extends Node2D

func _process(delta):
	change_scene()
	if Global.Go_to_cave == true:
		get_tree().change_scene_to_file("res://cave_inside.tscn")

func _on_world_transition_point_body_entered(body):
	if body.has_method("playerr"):
		Global.transition_scene = true


func _on_world_transition_point_body_exited(body):
	if body.has_method("playerr"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_Scene == "world":
			get_tree().change_scene_to_file("res://player/world.tscn")
			Global.finish_changescene()


func _on_area_2d_body_entered(body):
	if body.has_method("playerr"):
		Global.door_cave_area = true


func _on_area_2d_body_exited(body):
	if body.has_method("playerr"):
		Global.door_cave_area = false
