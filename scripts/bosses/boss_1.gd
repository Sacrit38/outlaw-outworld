extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var state_time = 0
var acceleration = 10
var melee = false
var dodge_1 = preload("res://scenes/bosses/boss_1_skills/dodge.tscn")
var dodge_2 = preload("res://scenes/bosses/boss_1_skills/dodge_1.tscn")
var range_1 = preload("res://scenes/bosses/boss_1_skills/range.tscn")
var animation_lock = false
var state = STATE_FLY

func start() -> void:
	Global.boss = self
	Main.move_cam = -1
	Player.backward = true
	position.x = -(get_viewport().size.x/2 - 75)
	#$AnimatedSprite2D.play("fly-walk")
	pass

func _physics_process(delta: float) -> void:
	if Global.game_running:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		#phase 3 movement
		if melee:
			velocity.x += acceleration
		
		update_animation()
		move_and_slide()

func phase_1() -> void:
	#var rando = randi_range(1, 3)
	#if rando == 1:
		set_state(STATE_DODGE)
		var skill_instance : Node2D = dodge_1.instantiate()
		var player_transform : CollisionShape2D = get_parent().get_parent().get_node("Outlaw/OutlawCollision")
		var parent : Node2D = get_parent()
		skill_instance.global_position = Vector2( player_transform.global_position.x - parent.global_position.x, (get_viewport().size.y/2) - 75)
		get_parent().add_child(skill_instance)
	#if rando == 2:
		#var skill_instance : Node2D = dodge_2.instantiate()
		#skill_instance.global_position = Vector2(-(get_viewport().size.x/2) + 50, (get_viewport().size.y/3)  - 50)
		#get_parent().add_child(skill_instance)
	#if rando == 3:
		#var skill_instance : Node2D = dodge_2.instantiate()
		#skill_instance.global_position = Vector2(-(get_viewport().size.x/2) + 50, -(get_viewport().size.y/4)  - 50)
		#get_parent().add_child(skill_instance)
	
#func phase_1_to_2() -> void:
	#position.x = (get_viewport().size.x/2 - 75)
	#pass
	
func phase_2() -> void:
	var rando = randi_range(1, 2)
	set_state(STATE_RANGE)
	if rando == 1:
		var skill_instance : Node2D = range_1.instantiate()
		skill_instance.global_position = Vector2(-(get_viewport().size.x/2) - 50, (get_viewport().size.y/3)  - 100)
		get_parent().add_child(skill_instance)
	if rando == 2:
		var skill_instance : Node2D = range_1.instantiate()
		skill_instance.global_position = Vector2(-(get_viewport().size.x/2) - 50, -(get_viewport().size.y/4)  - 50)
		get_parent().add_child(skill_instance)
	
	pass
	
func phase_3() -> void:
	melee = true
	pass

func _on_timer_timeout() -> void:
	state_time+=1
	if state_time < 5:
		phase_1()
		pass
	elif state_time < 15:
		phase_2()
		pass
	elif state_time < 21:
		phase_3()
		pass
	else :
		Global.boss_defeated()
		Global.next_chapter()
		Main.move_cam = 1
		Player.backward = false
	
	pass # Replace with function body.


func _on_area_up_body_entered(body: Node2D) -> void:
	if melee and body.name == "Outlaw":
		melee = false
		velocity.x = 0
		# call animation
		await get_tree().create_timer(.5).timeout
		position.x = -(get_viewport().size.x/2 - 75)
	
	pass # Replace with function body.


func _on_area_down_body_entered(body: Node2D) -> void:
	if melee and body.name == "Outlaw":
		melee = false
		velocity.x = 0
		#attack
		# call animation
		await get_tree().create_timer(.5).timeout
		position.x = -(get_viewport().size.x/2 - 75)
	
	pass # Replace with function body.

enum {
	STATE_FLY,
	STATE_DODGE,
	STATE_MELEE,
	STATE_RANGE,
}

func set_state(new_state):
	if animation_lock:
		return

	if state == new_state:
		return

	state = new_state
	animation_lock = true

	match state:
		STATE_FLY:
			animation_lock = false
			$AnimatedSprite2D.play("fly-walk")
		STATE_DODGE:
			$AnimatedSprite2D.play("dodgePhase")
		STATE_RANGE:
			$AnimatedSprite2D.play("rangePhase")
		STATE_MELEE:
			$AnimatedSprite2D.play("meleePhase")

func _on_animated_sprite_2d_animation_finished():
	animation_lock = false

func _on_animated_sprite_2d_animation_looped():
	animation_lock = false

func update_animation() -> void:
	if not animation_lock and state != STATE_FLY:
		set_state(STATE_FLY)
