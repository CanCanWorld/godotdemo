extends BaseNode2D
class_name NowEnemies

@onready var enemy1 = preload("res://enemy/assets/enemy1/enemy1.tscn")
@onready var enemy2 = preload("res://enemy/assets/enemy2/enemy2.tscn")
@onready var timer : Timer = $Timer
var tileMap : TileMap = null

func _ready() -> void:
	super._ready()
	tileMap = get_tree().get_first_node_in_group("map")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_wait_time(value):
	print("set_wait_time", value)
	timer.wait_time = value

func _on_timer_timeout() -> void:
	if get_tree().get_node_count_in_group("enemy") == 100:
		return
	add_enemy1()
	add_enemy2()
	pass # Replace with function body.

func add_enemy1():
	var enemy_position = player.global_position
	var enemyTemp: Enemy = enemy1.instantiate()
	add_child(enemyTemp)
	var dir = randf_range(0, 2 * PI)
	enemyTemp.global_position = enemy_position + Vector2(1000, 0).rotated(dir)

func add_enemy2():
	var enemy_position = player.global_position
	var enemyTemp: Enemy = enemy2.instantiate()
	add_child(enemyTemp)
	var dir = randf_range(0, 2 * PI)
	enemyTemp.global_position = enemy_position + Vector2(1000, 0).rotated(dir)
