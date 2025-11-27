extends Area2D
class_name outlaw_hurtbox

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox):
	if hitbox == null:
		return
	if hitbox is enemy_hitbox or ranged_enemy_hitbox or boss_rangeAttack or boss_dodgeAttack:
		owner.set_state(owner.STATE_HURT)
		if owner.has_method("take_damage"):
			owner.take_damage(1)
		
