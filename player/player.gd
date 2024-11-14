extends CharacterBody2D

var speed = 4
var sprintTime = 0
@onready var anim = $AnimatedSprite2D
@onready var ball = $RigidBody2D
@onready var sprintProgress = $SprintProgress
var sprint_time_sum = 0.5
var sprint_time_sleep_sum = 2
var sprint_time_sleep = 0
var isCanSprint = true
var sprint_scale = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		position += vector * speed * sprint_scale
		anim.speed_scale = sprint_scale
		if sprintTime < 0:
			sprint_time_sleep = sprint_time_sleep_sum
	else :
		#行走
		anim.speed_scale = 1
		position += vector * speed
	if sprint_time_sleep > 0:
		#等待冲刺冷却
		sprint_time_sleep -= delta
		print("冲刺冷却中", sprint_time_sleep)
		sprintProgress.value = 100 - sprint_time_sleep/ sprint_time_sleep_sum * 100
		if sprint_time_sleep <= 0:
			isCanSprint = true
	print(vector.x)
	if vector.x != 0:
		#朝向
		anim.flip_h = vector.x < 0
		anim.play()
	else :
		#停下
		anim.stop()
	move_and_slide()
	pass
