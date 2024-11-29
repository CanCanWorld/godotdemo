extends Node2D
class_name Ball

var base_hurt = 50
var hurt = base_hurt
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hurt = base_hurt + player.attack / 10
	pass


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("enemy"):
		var enemy = body as Enemy
		enemy.hurted(hurt, global_position)
		player.hp_recovery(int(hurt / 100))
	pass # Replace with function body.
