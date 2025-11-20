extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var skill_1 = preload("res://scenes/bosses/boss_1_skills/dodge.tscn")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func dodge_skill() -> void:
	var skill_instance : Node2D = skill_1.instantiate()
	skill_instance.global_position = Vector2(0, (get_viewport().size.y/2))
	$"../Camera2D".add_child(skill_instance)
	pass
	
func ranged_skill() -> void:
	
	pass
	
func melee_skill() -> void:
	
	pass

func _on_timer_timeout() -> void:
	var rndm = randi_range(0,2)
	if rndm == 0:
		dodge_skill()
		pass
	if rndm == 1:
		ranged_skill()
		pass
	if rndm == 2:
		melee_skill()
		pass
	pass # Replace with function body.
