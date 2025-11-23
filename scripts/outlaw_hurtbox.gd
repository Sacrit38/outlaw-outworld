class_name outlaw_hurtbox
extends Area2D


# Called when the node enters the scene tree for the first time.
#func _init() -> void:
	#collision_layer = 0
	#collision_mask = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox):
	if hitbox == null:
		return
	if hitbox is enemy_hitbox or hitbox is ranged_enemy_hitbox:
		if owner.has_method("take_damage"):
			owner.take_damage(1)
		
