extends Node2D

@onready var enemy = preload("res://enemy/enemy.tscn")
var tileMap : TileMap = null
const tag = "now_enemies"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tileMap = get_tree().get_first_node_in_group("map")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var num = randi_range(0, len(tileMap.get_used_cells(0)) - 1)
	var local_position = tileMap.map_to_local(tileMap.get_used_cells(0)[num])
	var enemyTemp: Enemy = enemy.instantiate()
	enemyTemp.position = local_position * tileMap.scale - position
	var c = randi_range(111111, 999999)
	add_child(enemyTemp)
	print(tag + "position", local_position)
	pass # Replace with function body.
