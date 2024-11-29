extends CanvasLayer

@onready var bomb_tscn = preload("res://skill/bomb/bomb.tscn")
@onready var chop_tscn = preload("res://skill/chop/chop.tscn")
@onready var rotate_ball_tscn = preload("res://skill/rotateBall/rotate_ball.tscn")

var player : Player
var update : SceneUpdate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	update = get_tree().get_first_node_in_group("update")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#老季
func _on_btn_1_pressed() -> void:
	hide()
	player.add_child(bomb_tscn.instantiate())
	update.chooseJi()
	player.chooseJi()
	player.once_passive_callable(Callable(
		func():
			Passive.half_base_exp()
	))
	player.passive_callable(Callable(
		func():
			Passive.max_hp_to_big()
	))
	get_tree().paused = false
	pass # Replace with function body.

#老王
func _on_btn_2_pressed() -> void:
	hide()
	update.chooseWang()
	player.chooseWang()
	get_tree().paused = false
	pass # Replace with function body.

#金山
func _on_btn_3_pressed() -> void:
	hide()
	update.chooseShan()
	player.chooseShan()
	player.add_child(chop_tscn.instantiate())
	get_tree().paused = false
	pass # Replace with function body.

#老汪
func _on_btn_4_pressed() -> void:
	hide()
	update.chooseWang2()
	player.chooseWang2()
	player.add_child(rotate_ball_tscn.instantiate())
	get_tree().paused = false
	pass # Replace with function body.

#我
func _on_btn_5_pressed() -> void:
	hide()
	update.chooseMe()
	player.chooseMe()
	player.add_child(bomb_tscn.instantiate())
	player.add_child(chop_tscn.instantiate())
	player.add_child(rotate_ball_tscn.instantiate())
	get_tree().paused = false
	pass # Replace with function body.
