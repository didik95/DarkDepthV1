extends Node2D

func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "WIN")

func _process(delta):
	if Global.Go_back_dream == true:
		get_tree().change_scene_to_file("res://menu.tscn")
	elif Global.Freedom == true:
		get_tree().quit()
