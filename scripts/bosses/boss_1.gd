extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var state_time = 0
var dodge_1 = preload("res://scenes/bosses/boss_1_skills/dodge.tscn")
var dodge_2 = preload("res://scenes/bosses/boss_1_skills/dodge_1.tscn")
var range_1 = preload("res://scenes/bosses/boss_1_skills/range.tscn")

func _ready() -> void:
	position.x = -(get_viewport().size.x/2 - 75)
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func phase_1() -> void:
	var rando = randi_range(1, 3)
	if rando == 1:
		var skill_instance : Node2D = dodge_1.instantiate()
		skill_instance.global_position = Vector2(0, (get_viewport().size.y/2) - 50)
		get_parent().add_child(skill_instance)
	if rando == 2:
		var skill_instance : Node2D = dodge_2.instantiate()
		skill_instance.global_position = Vector2(-(get_viewport().size.x/2) + 50, (get_viewport().size.y/3)  - 50)
		get_parent().add_child(skill_instance)
	if rando == 3:
		var skill_instance : Node2D = dodge_2.instantiate()
		skill_instance.global_position = Vector2(-(get_viewport().size.x/2) + 50, -(get_viewport().size.y/4)  - 50)
		get_parent().add_child(skill_instance)
	pass
	
func phase_1_to_2() -> void:
	position.x = (get_viewport().size.x/2 - 75)
	pass
	
func phase_2() -> void:
	var rando = randi_range(1, 2)
	if rando == 1:
		var skill_instance : Node2D = range_1.instantiate()
		skill_instance.global_position = Vector2((get_viewport().size.x/2) + 50, (get_viewport().size.y/3)  - 100)
		get_parent().add_child(skill_instance)
	if rando == 2:
		var skill_instance : Node2D = range_1.instantiate()
		skill_instance.global_position = Vector2((get_viewport().size.x/2) + 50, -(get_viewport().size.y/4)  - 50)
		get_parent().add_child(skill_instance)
	
	pass
	
func phase_3() -> void:
	
	pass

func _on_timer_timeout() -> void:
	state_time+=1 
	if state_time < 10:
		phase_1()
		pass
	elif state_time == 10: 
		phase_1_to_2()
	elif state_time < 16:
		phase_2()
		pass
	elif state_time < 21:
		phase_3()
		pass
	
	pass # Replace with function body.
