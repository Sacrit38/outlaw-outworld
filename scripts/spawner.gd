extends Node2D

# For spawning mechanism, if further
var melee_enemy_scene = preload("res://scenes/melee_enemy.tscn")
var ranged_enemy_scene = preload("res://scenes/ranged_enemy.tscn")
var obstacle_types := [melee_enemy_scene, ranged_enemy_scene]
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
	var ground : StaticBody2D = $"../../Ground"
	ground_height = (ground.get_node("CollisionShape2D").shape.size.y/2) * (ground.global_scale.y/2)
	pass # Replace with function body.


func generate_enemy():
	screen_size = get_viewport_rect().size
	#generate ground obstacle
	var type = randi() % obstacle_types.size()
	var enemy_type = obstacle_types[type]
	var enemy
	enemy = enemy_type.instantiate()
	
	#Get enemy texture height and scale
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
	var enemy_y : int = (screen_size.y/2) - ground_height - (enemy_height * enemy_scale.y /2) - 10
	
	# Add flying type if range 
	if type == 1:
		if randi() % obstacle_types.size() == 1:
			enemy_y -= 235
	
	last_enemy = enemy
	enemy.position = Vector2i(enemy_x, enemy_y)
	add_obs(enemy, 0, enemy_y)

func add_obs(obs, x, y):
	obs.position = Vector2i(x, y)
	add_child(obs)


func _on_timer_timeout() -> void:
	if Global.game_running:
		generate_enemy()
		pass # Replace with function body.
