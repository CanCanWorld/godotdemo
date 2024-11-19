extends Node2D

@onready var shoot_pos = $shoot_pos
@onready var enemy:CharacterBody2D = $enemy
@onready var timer = $Timer
@onready var bullet = preload("res://bullet/bullet.tscn")

var shoot_time = 1
var bullet_speed = 400
var bullet_hurt = 10
var attack_enemise: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if attack_enemise.size() != 0:
		var attack_enemy = attack_enemise[0]
		look_at(attack_enemy.global_position)
	else :
		rotation_degrees = -90
	pass


func _on_timer_timeout() -> void:
	print('enemy', "_on_timer_timeout")
	if attack_enemise.size() != 0:
		var now_bullet : Bullet = bullet.instantiate()
		now_bullet.speed = bullet_speed
		now_bullet.hurt = bullet_hurt
		now_bullet.position = shoot_pos.global_position
		now_bullet.dir = (attack_enemise[0].global_position - now_bullet.position).normalized()
		get_tree().root.add_child(now_bullet)
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") && !attack_enemise.has(body):
		attack_enemise.append(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy") && attack_enemise.has(body):
		attack_enemise.remove_at(attack_enemise.find(body))
	pass # Replace with function body.
