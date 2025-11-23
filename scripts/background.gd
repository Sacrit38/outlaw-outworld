extends ParallaxBackground

const speed = 250;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_running:
		$ParallaxLayer.motion_offset.x += speed * delta
		$ParallaxLayer2.motion_offset.x += speed * delta
		$ParallaxLayer3.motion_offset.x += speed * delta
		$ParallaxLayer4.motion_offset.x += speed * delta
