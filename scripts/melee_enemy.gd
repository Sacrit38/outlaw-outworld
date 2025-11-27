extends Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const speed :float = 500.0
var state = STATE_IDLE
var animation_lock = false

enum {
	STATE_IDLE,
	STATE_APPROACH,
	STATE_HIT
}


func set_state(new_state):
	if animation_lock == true:
		return # Don’t interrupt the current animation
	
	if state == new_state:
		return
	
	state = new_state
	animation_lock = true
	
	match state:
		STATE_IDLE:
			animated_sprite_2d.play("idle")
		STATE_APPROACH:
			animated_sprite_2d.play("approach")
		STATE_HIT:
			animated_sprite_2d.play("hit")

func _on_animated_sprite_2d_animation_finished() -> void:
	animation_lock = false

func _on_animated_sprite_2d_animation_looped():
	animation_lock = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state(STATE_IDLE)
	
func movement(delta: float) -> void:
	position.x += -speed * delta
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Global.game_running:
		if ray_cast_2d.is_colliding():
			print("detected")
			set_state(STATE_APPROACH)
		else:
			set_state(STATE_IDLE)
	
	
	#move
	movement(delta)
	
	

func delete(eliminated : bool) -> void:
	if eliminated:
		print("melee eliminated")
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	delete(true)
	pass # Replace with function body.	


func _on_melee_enemy_hitbox_area_entered(area: Area2D) -> void:
	set_state(STATE_HIT)	
