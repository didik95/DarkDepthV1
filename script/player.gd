extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldownm = true
var health = 300
var player_alive = true

var attack_ip = false

const  max_speed = 100
var currect_dir = "none"

func _ready():
	$AnimatedSprite2D.play("idle")

func  _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	playerr()
	update_health()
	story()
	
	if attack_ip == false:
		Global.player_attack = false
	elif attack_ip == true:
		Global.player_attack = true
	
	if health <= 0:
		player_alive = false
		health = 0
		print("player die")
		get_tree().change_scene_to_file("res://lose_menu.tscn")
	
	
func player_movement(delta):
	var anim = $AnimatedSprite2D
	
	if Input.is_action_pressed("ui_right"):
		currect_dir = "right"
		play_anim(1)
		velocity.x = max_speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		currect_dir = "left"
		play_anim(1)
		velocity.x = -max_speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		currect_dir = "down"
		play_anim(1)
		velocity.y = max_speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		currect_dir = "up"
		play_anim(1)
		velocity.y = -max_speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	

func play_anim(movement):
	var dir = currect_dir
	var anim = $AnimatedSprite2D
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			if attack_ip == false:
				anim.play("walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("idle_walk")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			if attack_ip == false:
				anim.play("walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("idle_walk")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			if attack_ip == false:
				anim.play("walk_down")
		elif movement == 0:
			if attack_ip == false:
				anim.play("idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			if attack_ip == false:
				anim.play("walk_up")
		elif movement == 0:
			if attack_ip == false:
				anim.play("idle_up")
func playerr():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("bos"):
		Global.bos_in_attack_range = true
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("bos"):
		Global.bos_in_attack_range = false
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldownm == true:
		health = health - 20
		enemy_attack_cooldownm = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldownm = true

func attack():
	var dir = currect_dir
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		$slash.play()
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("attack_side")
			$deal_attack_timer.start()
			
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack_side")
			$deal_attack_timer.start()
			
		if dir == "down":
			$AnimatedSprite2D.play("attack_down")
			$deal_attack_timer.start()
			
		if dir == "up":
			$AnimatedSprite2D.play("attack_up")
			$deal_attack_timer.start()
			


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 300:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regen_time_timeout():
	if health < 300:
		health = health + 20
		if health > 300:
			health = 300
	if health <= 0:
		health = 0

func story():
	if Global.start_story_in_range == true:
		if Input.is_action_just_pressed("story"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "start1")
	elif Global.sign_east_forest_in_area == true:
		if Input.is_action_just_pressed("story"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "forest_sign")
	elif Global.door_cave_area == true:
		if Input.is_action_just_pressed("story"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "door_cave")
	elif Global.start2_story_in_range == true:
		if Global.slime_tutorial_defeated or Global.slime2_tutorial_defeated == true:
			if Input.is_action_just_pressed("story"):
				DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "start3")
		elif Global.slime_tutorial_defeated or Global.slime2_tutorial_defeated == false:
			if Input.is_action_just_pressed("story"):
				DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "start2")
