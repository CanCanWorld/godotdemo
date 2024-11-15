extends Node2D

@onready var shoot_pos = $shoot_pos
@onready var timer = $Timer
@onready var bullet = preload("res://bullet/bullet.tscn")

var shoot_time = 1
var bullet_speed = 1400
var bullet_hurt = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var now_bullet : Bullet = bullet.instantiate()
	now_bullet.speed = bullet_speed
	now_bullet.hurt = bullet_hurt
	now_bullet.dir = Vector2(1, 0)
	now_bullet.position = shoot_pos.global_position
	get_tree().root.add_child(now_bullet)
	pass # Replace with function body.
