extends Node2D

func _ready():
	Global.game_first_loading = true
	Global.slime_tutorial_defeated = false
	Global.slime2_tutorial_defeated = false
	Global.start_story_in_range = false
	Global.start2_story_in_range = false
	Global.sign_east_forest_in_area = false
	Global.door_cave_area = false
	Global.Go_to_cave = false
	Global.bos_defeated = false
	Global.Go_to_win = false
	Global.Go_back_dream = false
	Global.Freedom = false
	DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "tutorial")
	if Global.game_first_loading == true:
		$Player.position.x = Global.player_start_posx
		$Player.position.y = Global.player_start_posy
	else:
		$Player.position.x = Global.player_exit_cliffside_posx
		$Player.position.y = Global.player_exit_cliffside_posy

func _process(delta):
	change_scene()

func _on_caveside_transition_point_body_entered(body):
	if body.has_method("playerr"):
		Global.transition_scene = true


func _on_caveside_transition_point_body_exited(body):
	if body.has_method("playerr"):
		Global.transition_scene = false
		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_Scene == "world":
			get_tree().change_scene_to_file("res://cave_side.tscn")
			Global.game_first_loading = false
			Global.finish_changescene()


func _on_area_2d_body_entered(body):
	if body.has_method("playerr"):
		Global.start_story_in_range = true


func _on_area_2d_body_exited(body):
	if body.has_method("playerr"):
		Global.start_story_in_range = false


func _on_story_2_body_entered(body):
	if body.has_method("playerr"):
		Global.start2_story_in_range = true


func _on_story_2_body_exited(body):
	if body.has_method("playerr"):
		Global.start2_story_in_range = false


func _on_sign_forest_body_entered(body):
	if body.has_method("playerr"):
		Global.sign_east_forest_in_area = true


func _on_sign_forest_body_exited(body):
	if body.has_method("playerr"):
		Global.sign_east_forest_in_area = false
