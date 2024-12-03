extends BaseNode2D
class_name NowEnemies

@onready var enemy1_tscn = preload("res://enemy/assets/enemy1/enemy1.tscn")
@onready var enemy2_tscn = preload("res://enemy/assets/enemy2/enemy2.tscn")
@onready var enemy3_tscn = preload("res://enemy/assets/enemy3/enemy3.tscn")
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
	add_enemy(enemy1_tscn)
	add_enemy(enemy2_tscn)
	add_enemy(enemy3_tscn)


func add_enemy(enemy_tscn: PackedScene):
	var enemyTemp: Enemy = enemy_tscn.instantiate()
	add_child(enemyTemp)
	var dir = randf_range(0, 2 * PI)
	enemyTemp.global_position = player.global_position + Vector2(1000, 0).rotated(dir)
	if randi_range(1, 10) < 2:
		enemyTemp.scale *= 2
		enemyTemp.speed *= 2
		enemyTemp.max_hp *= 2
		enemyTemp.hp *= 2
		enemyTemp.hurt *= 2
	else :
		enemyTemp.scale = Vector2.ONE
