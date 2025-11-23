class_name enemy_hurtbox
extends Area2D


# Called when the node enters the scene tree for the first time.
#func _init() -> void:
	#collision_layer = 0
	#collision_mask = 32


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox):
	if hitbox == null:
		return
		
	if hitbox is melee_hitbox or hitbox is range_attack:
		if owner.has_method("delete"):
			owner.delete(true)
