extends Node2D

@onready var enemy = preload("res://enemy/enemy.tscn")
var tileMap : TileMap = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tileMap = get_tree().get_first_node_in_group("map")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var num = randi_range(0, len(tileMap.get_used_cells(0)))
	var local_position = tileMap.map_to_local(tileMap.get_used_cells(0)[num])
	var enemyTemp: Node2D = enemy.instantiate()
	enemyTemp.position = local_position
	add_child(enemyTemp)
	pass # Replace with function body.
