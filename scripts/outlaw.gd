extends CharacterBody2D

var animation_lock = false
var state = STATE_IDLE
var can_take_damage: bool = true
@onready var scereus: AnimatedSprite2D = $Scereus
@onready var slash_effect: AnimatedSprite2D = $SlashEffect

enum {
	STATE_RUN,
	STATE_JUMP,
	STATE_FALL,
	STATE_FLOAT,
	STATE_ATTACK,
	STATE_RANGED,
	STATE_HURT,
	STATE_IDLE,
	#STATE_SWAP
}

enum boss_state{
	START_BOSS,
	BOSSING,
	END_BOSS,
	NO_BOSS
}
# START_BOSS to test boss
static var boss = boss_state.NO_BOSS

func set_state(new_state):
	if Input.is_action_just_pressed("attack_button") and Melee and not is_on_floor():
		scereus.play("attack")
		return
	
	if Input.is_action_just_pressed("attack_button") and not Melee and not is_on_floor():
		scereus.play("ranged")
		return
	
	if animation_lock == true:
		return # Don’t interrupt the current animation
	
	if state == new_state:
		return
	state = new_state
	animation_lock = true
	
	match state:
		STATE_RUN:
			animation_lock = false
			scereus.play("run")
		STATE_JUMP:
			scereus.play("jump")
		STATE_FALL:
			scereus.play("fall")
		STATE_FLOAT:
			scereus.play("float")
		STATE_ATTACK:
			scereus.play("attack")
			slash_effect.play("default")
		STATE_RANGED:
			scereus.play("ranged")
		STATE_HURT:
			scereus.play("hurt")
		STATE_IDLE:
			scereus.play("idle")
		#STATE_SWAP:
			#scereus.play("swap")

func _on_animated_sprite_2d_animation_finished() -> void:
	animation_lock = false
func _on_animated_sprite_2d_animation_looped():
	animation_lock = false

#func play_slash_effect():
	#slash_effect.show()
	#$SlashEffect.play("default")
	#slash_effect.hide()

func update_animation():
	if not is_on_floor():
		if velocity.y < 0:
			if state != STATE_JUMP:
				set_state(STATE_JUMP)
		elif velocity.y == 0:
			if state != STATE_FLOAT:
				set_state(STATE_FLOAT)
		else :
			if state != STATE_FALL:
				set_state(STATE_FALL)
	elif Global.game_running:
		if state != STATE_RUN:
				set_state(STATE_RUN)
	else:
		if state != STATE_IDLE:
			set_state(STATE_IDLE)

func weapon_swap_effect() -> void:
	scereus.modulate = Color(1, 1, 1, 1)
	await get_tree().create_timer(0.05).timeout
	scereus.modulate = Color(1, 1, 1, 0.9)

func _ready():
	set_state(STATE_IDLE)
	$MeleeHitbox/Hitbox.disabled = true

const GRAVITY : int = 4200
const JUMP_VELOCITY = -1800
var Melee : bool = true 
var can_attack: bool = true
var Projectile = preload("uid://c08faj4cqcv8g") 
signal game_over


func shoot() -> void:
	var projectile = Projectile.instantiate()
	projectile.global_position = global_position
	if boss == boss_state.BOSSING:
		projectile.reversed()
	get_parent().add_child(projectile)

func actions() -> void:
	if Input.is_action_just_pressed("weapon_swap"):
		await weapon_swap_effect()
		#set_state(STATE_SWAP)
		Melee = !Melee
	
	if Input.is_action_just_pressed("attack_button") and Melee and can_attack:
		$MeleeHitbox/Hitbox.disabled = false
		can_attack = false
		if state != STATE_ATTACK:
			set_state(STATE_ATTACK)
			#play_slash_effect()
		await get_tree().create_timer(0.5).timeout
		can_attack = true
		$MeleeHitbox/Hitbox.disabled = true
	
	elif Input.is_action_just_pressed("attack_button") and not Melee and can_attack:
		shoot() 
		can_attack = false
		if state != STATE_RANGED:
			set_state(STATE_RANGED)
		await get_tree().create_timer(0.5).timeout
		can_attack = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if Global.game_running:
		if not is_on_floor():
			velocity.y += GRAVITY * delta
		
		if is_on_floor():
			# Handle jump.
			if Input.is_action_just_pressed("jump_button") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				
		if boss == boss_state.START_BOSS:
			scale.x = -scale.x
			boss = boss_state.BOSSING
			
	if health.get_health() <= 0:
		emit_signal("game_over") 
	
	update_animation()
	move_and_slide()
	
func take_damage(amount: int) -> void:
	health.set_health(health.get_health()-amount)
	print(str(health))
