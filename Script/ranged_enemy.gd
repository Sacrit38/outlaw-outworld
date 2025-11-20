extends CharacterBody2D
@export var bullet_scene: PackedScene
@export  var fire_rate = 0.5

@onready var muzzle = $Sprite2D/muzzle

var reload = 0.0

func _process(delta: float) -> void:
	reload -= delta
	if reload <= 0.0:
		fire()
		reload = fire_rate
	

func fire():
	var bullet = bullet_scene.instantiate()
	
	bullet.global_position = muzzle.global_position
	bullet.rotation = rotation
	
	get_tree().root.add_child(bullet)
