extends BaseNode2D

@onready var enemy = preload("res://enemy/enemy.tscn")
var tileMap : TileMap = null
const tag = "now_enemies"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	tileMap = get_tree().get_first_node_in_group("map")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if get_tree().get_node_count_in_group("enemy") == 100:
		return
	var enemy_position = player.global_position
	var enemyTemp: Enemy = enemy.instantiate()
	add_child(enemyTemp)
	var dir = randf_range(0, 2 * PI)
	print(dir)
	enemyTemp.global_position = enemy_position + Vector2(1000, 0).rotated(dir)
	pass # Replace with function body.
