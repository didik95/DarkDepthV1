extends Node


var enemy_alive = true
var bos_alive = true

var player_current_attack = false
var player_attack = false

var current_Scene = "world"
var transition_scene = false

var player_exit_cliffside_posx = 660
var player_exit_cliffside_posy = 159
var player_start_posx = 150
var player_start_posy = 173

var game_first_loading = true

func finish_changescene():
	if transition_scene == true:
		transition_scene = false
		if current_Scene == "world":
			current_Scene = "cave_side"
		else:
			current_Scene = "world"

var slime_tutorial_defeated = false
var slime2_tutorial_defeated = false
var start_story_in_range = false
var start2_story_in_range = false
var sign_east_forest_in_area = false
var door_cave_area = false
var Go_to_cave = false
var bos_defeated = false
var Go_to_win = false
var Go_back_dream = false
var Freedom = false

