extends Node2D

# For spawning mechanism, if further
var melee_enemy_scene = preload("res://scenes/melee_enemy.tscn")
var ranged_enemy_scene = preload("res://scenes/ranged_enemy.tscn")
var obstacle_types := [melee_enemy_scene, ranged_enemy_scene]
var obstacle : Array
var flying_heights := [200, 390]

const outlaw_start := Vector2i(100, 510)
const camera_start := Vector2i(576, 321)

const speed :float = 500.0

# Game variable
var last_obs
var screen_size
var ground_height : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	$Outlaw.position = outlaw_start
	$Camera2D.position = camera_start
	$Ground.position = Vector2i(576,620)
	$Ground2.position = Vector2i(1728,620)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	generate_obs()
	
	$Ground.position.x += -speed * delta
	$Ground2.position.x += -speed * delta
	
	for obs in obstacle:
		obs.position.x += -speed * delta
		if obs.position.x <= -576:
			obstacle.erase(obs)
			obs.queue_free()
	
	$Outlaw.actions()
	
	if $Ground.position.x <= -576:
		$Ground.position.x = 1728
	elif $Ground2.position.x <= -576:
		$Ground2.position.x = 1728

func generate_obs():
	#generate ground obstacle
	if obstacle.is_empty():
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs
		obs = obs_type.instantiate()
		
		var anim_sprite = obs.get_node("AnimatedSprite2D")
		var obs_height = anim_sprite.sprite_frames.get_frame_texture(anim_sprite.animation, anim_sprite.frame).get_height()
		var obs_scale = obs.get_node("AnimatedSprite2D").scale
		
		var obs_x : int = screen_size.x + 100
		var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y /2) + 5
		
		last_obs = obs
		obs.position = Vector2i(obs_x, obs_y)
		add_child(obs)
		obstacle.append(obs)
