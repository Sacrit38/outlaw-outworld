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
var last_enemy
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
	generate_enemy()
	
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

func generate_enemy():
	#generate ground obstacle
	if obstacle.is_empty() or last_enemy.position.x < randi_range(300, 500):
		var enemy_type = obstacle_types[randi() % obstacle_types.size()]
		var enemy
		enemy = enemy_type.instantiate()
		
		var enemy_height : int = 100
		var enemy_scale : Vector2 = Vector2.ONE
		if enemy.has_node("AnimatedSprite2D"): 
			var anim_sprite = enemy.get_node("AnimatedSprite2D")
			enemy_height = anim_sprite.sprite_frames.get_frame_texture(anim_sprite.animation, anim_sprite.frame).get_height()
			enemy_scale = enemy.get_node("AnimatedSprite2D").scale
		elif enemy.has_node("Sprite2D"):
			enemy_height = enemy.get_node("Sprite2D").texture.get_height()
			enemy_scale = enemy.get_node("Sprite2D").scale
		
		var enemy_x : int = screen_size.x + 100
		var enemy_y : int = screen_size.y + ground_height - (enemy_height * enemy_scale.y /2) + 5
		
		last_enemy = enemy
		enemy.position = Vector2i(enemy_x, enemy_y)
		add_obs(enemy, enemy_x, enemy_y)

func add_obs(obs, x, y):
	obs.position = Vector2i(x, y)
	add_child(obs)
	obstacle.append(obs)
