extends CharacterBody2D

var speed = 8 
var sprintTime = 0
@onready var playerAnim = $PlayerAnim
@onready var ball = $RigidBody2D
@onready var sprintProgress = $SprintProgress
var sprint_time_sum = 2.5
var sprint_time_sleep_sum = 2
var sprint_time_sleep = 0
var isCanSprint = true
var sprint_scale = 2
var lastDir = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#choosePlayer("player1")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var y = Input.get_axis("下", "上")
	var vector = Input.get_vector("左","右","上", "下")
	if Input.is_action_just_pressed("冲刺"):
		if isCanSprint:
			sprintTime = sprint_time_sum
	if sprintTime > 0:
		#冲刺
		isCanSprint = false
		sprintTime -= delta
		sprintProgress.value = sprintTime * 100 / sprint_time_sum
		print("冲刺中", sprintTime)
		if vector.x > 0:
			playerAnim.animation = "run_right"
		elif vector.x < 0:
			playerAnim.animation = "run_left"
		elif vector.x == 0:
			if vector.y > 0:
				playerAnim.animation = "run"
			elif vector.y < 0:
				playerAnim.animation = "run_back"
		position += vector * speed * sprint_scale
		if sprintTime < 0:
			sprint_time_sleep = sprint_time_sleep_sum
	elif vector.x != 0||vector.y != 0:
		#行走
		lastDir = vector
		print("行走", vector)
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
	if sprint_time_sleep > 0:
		#等待冲刺冷却
		sprint_time_sleep -= delta
		print("冲刺冷却中", sprint_time_sleep)
		sprintProgress.value = 100 - sprint_time_sleep / sprint_time_sleep_sum * 100
		if sprint_time_sleep <= 0:
			isCanSprint = true
	if vector.x == 0&&vector.y == 0:
		#停下
		print("停下", lastDir)
		if lastDir.x > 0:
			print("idle_right")
			playerAnim.animation = "idle_right"
		elif lastDir.x < 0:
			print("idle_left")
			playerAnim.animation = "idle_left"
		elif lastDir.x == 0:
			if lastDir.y > 0:
				print("idle")
				playerAnim.animation = "idle"
			elif lastDir.y < 0:
				print("idle_back")
				playerAnim.animation = "idle_back"
	move_and_slide()
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
