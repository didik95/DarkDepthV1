extends CharacterBody2D
var speed = 40
var player_chase = false
var player = null
var health = 100
var player_inattack_zone
var can_take_damage = true
func _physics_process(delta):
	deal_with_damage()
	enemy()
	update_health()
	var anim = $AnimatedSprite2D
	if Global.enemy_alive == false:
		Global.slime_tutorial_defeated = true
	if health == 0:
		Global.enemy_alive = false
		anim.play("death_slime")
		health = -1
		$enemy_hitbox/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
	if health > 0:
		if player_chase:
			velocity = position.direction_to(player.position) * 40
			move_and_slide()
			$AnimatedSprite2D.play(("walk_slime"), 1)
			if player.position.x - position.x < 0:
				anim.flip_h = true
			else:
				anim.flip_h = false
		else:
			anim.play("idle_slime")
func _on_detect_area_body_entered(body):
	player = body
	player_chase = true

func _on_detect_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("playerr"):
		player_inattack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("playerr"):
		player_inattack_zone = false

func deal_with_damage():
	var anim = $AnimatedSprite2D
	if player_inattack_zone and Global.player_current_attack == true:
		if Global.player_attack == true:
			if can_take_damage == true:
				anim.play("took_damage")
				health = health - 20
				$take_damage_cd.start()
				can_take_damage = false
				print("slime health = ", health)
		

func _on_take_damage_cd_timeout():
	can_take_damage = true

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true



