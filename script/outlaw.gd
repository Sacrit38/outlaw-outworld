extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_VELOCITY = -1800
var Melee : bool = true 
var can_shoot: bool = true

var Projectile = preload("res://Scene/Projectile.tscn") 

func shoot() -> void:
	var p = Projectile.instantiate()
	p.global_position = global_position
	get_parent().add_child(p)

func actions() -> void:
	$MeleeHitbox.disabled = true
	
	if Input.is_action_just_pressed("weapon_swap"):
		if not Melee:
			Melee = true
		else:
			Melee = false
	
	if Input.is_action_just_pressed("attack_button") and Melee:
		$MeleeHitbox.disabled = false
	elif Input.is_action_just_pressed("attack_button") and not Melee and can_shoot:
		shoot() 
		can_shoot = false
		await get_tree().create_timer(1.0).timeout
		can_shoot = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if is_on_floor():
		# Handle jump.
		if Input.is_action_just_pressed("jump_button") and is_on_floor():
			velocity.y = JUMP_VELOCITY

	move_and_slide()
