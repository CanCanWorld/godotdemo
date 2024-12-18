extends CanvasLayer

@onready var hp_progress = %hp_progress
@onready var hp_label = %hp_label
@onready var exp_progress = %exp_progress
@onready var exp_label = %exp_label
@onready var time_label : Label = %time
var player : Player
var press_position : Vector2 = Vector2.ZERO
var last_drag_position : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hp_progress.max_value = player.max_hp
	hp_label.text = str(player.hp) + "/" + str(player.max_hp)
	hp_progress.value = player.hp
	exp_progress.max_value = player.max_exp
	exp_label.text = "LV." + str(player.level)
	exp_progress.value = player.exp
	pass


func _on_timer_timeout() -> void:
	GameMain.now_game_time -= 1
	var now_enemies : NowEnemies = get_tree().get_first_node_in_group("now_enemies")
	now_enemies.set_wait_time(max(0.0016 * GameMain.now_game_time, 0.01))
	time_label.text = str(GameMain.now_game_time)
	if GameMain.now_game_time == 0:
		get_tree().paused = true
		var end : EndUi = get_tree().root.get_node("/root/bgMap/end")
		end.is_success = true
		end.show()
	pass # Replace with function body.

	
