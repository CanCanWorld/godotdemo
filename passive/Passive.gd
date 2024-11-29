extends Node

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass

#触发一次的被动
func half_base_exp():
	print("一半的经验")
	player.max_exp /= 2
	player.base_exp /= 2

#持续触发的被动
func max_hp_to_big():
	var hp_scale = 1
	var attack_scale = 1
	if player.max_exp > player.base_max_hp:
		hp_scale = player.max_hp / player.base_max_hp
	if player.attack > player.base_attack:
		attack_scale = player.attack / player.base_attack
	player.scale = Vector2.ONE *  hp_scale / attack_scale

	
