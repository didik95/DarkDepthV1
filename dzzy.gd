extends Node2D

func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "bos")

func _process(delta):
	if Global.Go_to_win == true:
		get_tree().change_scene_to_file("res://win_scene.tscn")
