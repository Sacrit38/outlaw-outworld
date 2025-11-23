extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox):
	if hitbox == null:
		return
	
	if hitbox is range_attack:
		if owner.has_method("delete"):
			owner.delete(true)
