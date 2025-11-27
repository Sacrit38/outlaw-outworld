extends Area2D 
@onready var hit_dead: AudioStreamPlayer2D = $"../Audio/HitDead"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox):
	if hitbox == null:
		return
	
	if hitbox is range_attack:
		if owner.has_method("delete"):
			hit_dead.pitch_scale = randf_range(0.85, 1.15)
			hit_dead.play()
			Global.score += 200*Global.SCORE_MODIFIER
			owner.delete(true)
