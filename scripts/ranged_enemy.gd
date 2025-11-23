extends CharacterBody2D
@export var bullet_scene: PackedScene
@export  var fire_rate = 2.5

@onready var muzzle = $Sprite2D/muzzle

var stop = false
var reload = 1.33
const speed :float = 500.0

func _ready() -> void:
	await get_tree().create_timer(.5, true, true).timeout
	stop = true
	
	pass

func _process(delta: float) -> void:
	if Global.game_running:
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

func fire():
	var bullet = bullet_scene.instantiate()
	
	bullet.global_position = muzzle.global_position
	bullet.rotation = rotation
	
	get_tree().root.add_child(bullet)
	
func delete(eliminated : bool) -> void:
	if eliminated:
		print("range eliminated")
		#queue_free()
