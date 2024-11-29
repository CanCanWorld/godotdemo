extends Node2D
class_name Hand

var attacked_enemy : Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if attacked_enemy != null:
		attacked_enemy.isDone = false
	queue_free()
	pass # Replace with function body.

func attack(enemy: Enemy):
	enemy.done()
	attacked_enemy = enemy
