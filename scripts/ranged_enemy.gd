extends CharacterBody2D
@export var bullet_scene: PackedScene
@export  var fire_rate = 2.5
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var muzzle: Marker2D = %muzzle
@onready var hit_dead: AudioStreamPlayer2D = $Audio/HitDead
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var stop = false
var reload = .5
const speed :float = 500.0

var state = STATE_FLY
var animation_lock = false

enum {
	STATE_FLY,
	STATE_SHOOT,
}


func set_state(new_state):
	if animation_lock == true:
		return # Don’t interrupt the current animation
	
	if state == new_state:
		return
	
	state = new_state
	animation_lock = true
	
	match state:
		STATE_FLY:
			animated_sprite_2d.play("fly")
		STATE_SHOOT:
			animated_sprite_2d.play("shoot")

func _on_animated_sprite_2d_animation_finished() -> void:
	animation_lock = false

func _on_animated_sprite_2d_animation_looped():
	animation_lock = false

func _ready() -> void:
	set_state(STATE_FLY)
	await get_tree().create_timer(.5, true, true).timeout
	stop = true
	
	pass

func _process(delta: float) -> void:
	if Global.game_running:
		# move into the scene
		if stop:
			reload -= delta
			if reload <= 0.0:
				fire()
				reload = fire_rate

func _physics_process(_delta: float) -> void:
	if Global.game_running:
		# move into the scene
		if !stop:
			velocity.x = -speed
			move_and_slide()
			pass
	if state != STATE_FLY:
		set_state(STATE_FLY)

func fire():
	var bullet = bullet_scene.instantiate()
	if state != STATE_SHOOT:
		set_state(STATE_SHOOT)
	
	bullet.global_position = muzzle.global_position
	bullet.rotation = rotation
	
	get_tree().root.add_child(bullet)

func delete(eliminated : bool) -> void:
	if eliminated:
		animation_player.play("dead")
