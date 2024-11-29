extends BaseNode2D
class_name Trap

@onready var hand_tscn = preload("res://skill/trap/hand/hand.tscn")

var enemise : Array[Enemy] = []

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemise.append(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy:
		enemise.pop_at(enemise.find(body))


func _on_timer_timeout() -> void:
	if enemise.size() == 0:
		return
	enemise.sort_custom(
		func(a : Enemy, b : Enemy):
			return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position)
	)
	var hand : Hand = hand_tscn.instantiate()
	get_tree().root.add_child(hand)
	hand.global_position = enemise[0].global_position
	hand.attack(enemise[0])
	
	pass # Replace with function body.
