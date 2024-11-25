extends Node2D

var player : Player

var list = [
	{
		"title": "回复LV.1",
		"desc": "每秒恢复最大生命的1%（最低为1）",
		"value": 0.01
	},
	{
		"title": "回复LV.2",
		"desc": "每秒恢复最大生命的2%（最低为1）",
		"value": 0.02
	},
	{
		"title": "回复LV.3",
		"desc": "每秒恢复最大生命的3%（最低为1）",
		"value": 0.03
	},
	{
		"title": "回复LV.4",
		"desc": "每秒恢复最大生命的4%（最低为1）",
		"value": 0.04
	},
	{
		"title": "回复LV.5",
		"desc": "每秒恢复最大生命的5%（最低为1）",
		"value": 0.05
	},
]

var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	player.hp += max(int(player.max_hp * list[level-1].value), 1)
	if player.hp > player.max_hp:
		player.hp = player.max_hp
	pass # Replace with function body.
