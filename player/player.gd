extends CharacterBody2D

class_name Player

@onready var ball = $RigidBody2D
@onready var ji = $ji
@onready var wang = $wang
@onready var shan = $shan
@onready var wang2 = $wang2
@onready var me = $me
@onready var playerAnim = $ji
@onready var recovery_tscn = preload("res://recovery/recovery.tscn")

var speed = 4
var sprintTime = 0
var lastDir = Vector2.ZERO
var base_max_hp = 1000
var max_hp = base_max_hp
var hp = base_max_hp
var base_exp = 6
var max_exp = base_exp
var exp = 0
var level = 1
var recovery = 0
var base_attack = 100
var attack = base_attack
var isFirst = false
var once_passive : Callable = func(): pass
var passive : Callable = func(): pass

func once_passive_callable(callable: Callable):
	once_passive = callable
	isFirst = true

func passive_callable(callable: Callable):
	passive = callable


func chooseJi():
	playerAnim = ji
	ji.show()

func chooseWang():
	playerAnim = wang
	wang.show()

func chooseShan():
	playerAnim = shan
	shan.show()

func chooseWang2():
	playerAnim = wang2
	wang2.show()

func chooseMe():
	playerAnim = me
	me.show()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	walk()
	move_and_slide()
	judge_hp()
	if isFirst: 
		once_passive.call()
		isFirst = false
	passive.call()
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("drop_item"):
		var drop_item = body as DropItem
		drop_item.isMoving = true
	pass # Replace with function body.


func _on_stop_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("drop_item"):
		var drop_item = body as DropItem
		drop_item.isMoving = false
		#获取经验
		get_exp()
		drop_item.queue_free()
	pass # Replace with function body.

func get_exp():
	exp += 1
	if exp >= max_exp:
		#升级
		exp = 0
		level += 1
		max_exp = level * base_exp
		get_tree().paused = true
		var update = get_tree().get_first_node_in_group("update")
		update.show()

func hp_recovery(recovery: float):
	if hp == max_hp:
		return
	if recovery <= 0:
		recovery = 1
	hp += recovery
	if hp > max_hp:
		hp = max_hp
	var recovery_text_obj: RecoveryText = recovery_tscn.instantiate()
	add_child(recovery_text_obj)
	recovery_text_obj.set_text(str(recovery))
	recovery_text_obj.global_position = global_position - Vector2(randi_range(0, 40), 0)

func hurt(attack : float):
	hp -= attack
	

func add_max_hp(value: int): 
	max_hp += value
	hp += value

func judge_hp():
	if hp <= 0:
		get_tree().paused = true
		var end : EndUi = get_tree().root.get_node("/root/bgMap/end")
		end.is_success = false
		end.show()

func walk():
	var y = Input.get_axis("下", "上")
	var vector = Input.get_vector("左","右","上", "下")
	if vector.x != 0||vector.y != 0:
		#行走
		lastDir = vector
		playerAnim.animation = "run"
		position += vector * speed
		if vector.x != 0:
			playerAnim.flip_h = vector.x < 0
	if vector.x == 0&&vector.y == 0:
		#停下
		playerAnim.animation = "idle"
