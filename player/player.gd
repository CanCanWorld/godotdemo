extends CharacterBody2D

class_name Player

var speed = 4 
var sprintTime = 0
@onready var playerAnim = $PlayerAnim
@onready var ball = $RigidBody2D
@onready var sprintProgress = $SprintProgress
@onready var recovery_tscn = preload("res://recovery/recovery.tscn")
var lastDir = Vector2.ZERO
var max_hp = 1000
var hp = max_hp
var max_exp = 10
var base_exp = 2
var exp = 0
var level = 1
var recovery = 0
var attack = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#choosePlayer("player1")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	walk()
	move_and_slide()
	judge_hp()
	pass
	
func choosePlayer(name: String):
	playerAnim.sprite_frames.clear_all()
	var sprite_frames_custom = SpriteFrames.new()
	sprite_frames_custom.add_animation("run")
	sprite_frames_custom.set_animation_loop("run", true	)
	sprite_frames_custom.set_animation_speed("run", 15)
	var texture_size = Vector2(192, 48)
	var frame_size = Vector2(48, 48)
	var full_texture = load("res://player/assets/" + name + "/creature-sheet.png")
	var x_num = int(texture_size.x / frame_size.x)
	var y_num = int(texture_size.y / frame_size.y)
	for y in y_num:
		for x in x_num:
			var frame = AtlasTexture.new()
			frame.atlas = full_texture
			frame.region = Rect2(Vector2(x, y) * frame_size, frame_size)
			sprite_frames_custom.add_frame("run", frame)
	playerAnim.sprite_frames = sprite_frames_custom
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
	if recovery <= 0:
		recovery = 1
	hp += recovery
	if hp > max_hp:
		hp = max_hp
	var recovery_text_obj: RecoveryText = recovery_tscn.instantiate()
	add_child(recovery_text_obj)
	recovery_text_obj.set_text(str(recovery))
	recovery_text_obj.global_position = global_position

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
		playerAnim.speed_scale = 1
		if vector.x > 0:
			playerAnim.animation = "walk_right"
		elif vector.x < 0:
			playerAnim.animation = "walk_left"
		elif vector.x == 0:
			if vector.y > 0:
				playerAnim.animation = "walk"
			elif vector.y < 0:
				playerAnim.animation = "walk_back"
		position += vector * speed
	if vector.x == 0&&vector.y == 0:
		#停下
		if lastDir.x > 0:
			playerAnim.animation = "idle_right"
		elif lastDir.x < 0:
			playerAnim.animation = "idle_left"
		elif lastDir.x == 0:
			if lastDir.y > 0:
				playerAnim.animation = "idle"
			elif lastDir.y < 0:
				playerAnim.animation = "idle_back"
