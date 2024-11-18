extends Node2D

@onready var shoot_pos = $shoot_pos
@onready var enemy:CharacterBody2D = $enemy
@onready var timer = $Timer
@onready var bullet = preload("res://bullet/bullet.tscn")

var shoot_time = 1
var bullet_speed = 400
var bullet_hurt = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print('enemy', "_on_timer_timeout")
	var now_bullet :  = bullet.instantiate()
	now_bullet.speed = bullet_speed
	now_bullet.hurt = bullet_hurt
	now_bullet.position = shoot_pos.global_position
	var enemise = get_tree().get_nodes_in_group("enemy")
	var player:CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
	for item in enemise: 
		var enemy = item as Node2D
		now_bullet.dir = (enemy.position - player.position - position).normalized()
		print('enemy', enemy.position)
		print('enemy', player.position + position)
	get_tree().root.add_child(now_bullet)
	pass # Replace with function body.
