extends Area2D

@onready var outlaw = get_parent()

var invincible_time:float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", enemy_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if invincible_time > 0:
		invincible_time -= delta

func enemy_hit(body):
	if (body.is_in_group("melee_enemy") or body.is_in_group("range_enemy_bullet")) and invincible_time == 0.0:
		outlaw.take_damage(1)
		invincible_time = 1.0
