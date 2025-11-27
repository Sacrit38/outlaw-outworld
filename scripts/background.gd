extends ParallaxBackground

const speed = 250;
var chapter
@onready var main = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chapter = 1
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if chapter != Global.chapter and Global.chapter == 2:
		chapter = 2
		$Sprite2D.texture = load("res://assets/parallax background/s2/7.png")
		$ParallaxLayer/Sprite2D.texture = load("res://assets/parallax background/s2/6.png")
		$ParallaxLayer2/Sprite2D.texture = load("res://assets/parallax background/s2/5.png")
		$ParallaxLayer3/Sprite2D.texture = load("res://assets/parallax background/s2/4.png")
		$ParallaxLayer4/Sprite2D.texture = load("res://assets/parallax background/s2/3.png")
		$ParallaxLayer5/Sprite2D.texture = load("res://assets/parallax background/s2/2.png")
		$ParallaxLayer5/Ground.hide()
	if Global.game_running:
		$ParallaxLayer.motion_offset.x += speed * delta
		$ParallaxLayer2.motion_offset.x += speed * delta
		$ParallaxLayer3.motion_offset.x += speed * delta
		$ParallaxLayer4.motion_offset.x += speed * delta
