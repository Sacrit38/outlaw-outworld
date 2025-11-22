extends CharacterBody2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var state
#var animation_lock = false

enum {
	STATE_IDLE,
	STATE_APPROACH
}
const speed :float = 500.0

func set_state(new_state):
	#if animation_lock == true:
		#return # Don’t interrupt the current animation
	
	if state == new_state:
		return
	
	state = new_state
	#animation_lock = true
	
	match state:
		STATE_IDLE:
			animated_sprite_2d.play("idle")
		STATE_APPROACH:
			animated_sprite_2d.play("approach")

#func _on_animated_sprite_2d_animation_finished() -> void:
	#animation_lock = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state(STATE_IDLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		print("detect")
		set_state(STATE_APPROACH)
	else:
		set_state(STATE_IDLE)
	
	#move
	velocity.x = -speed
	move_and_slide()
	
