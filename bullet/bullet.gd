extends BaseCharacterBody2D

class_name Bullet

@onready var bullet_anim = $BulletAnim
@onready var bullet_tscn = preload("res://bullet/bullet.tscn")
var dir = Vector2.ZERO
var speed = 200
var hurt = 5

func _ready() -> void:
	super._ready()


func _process(delta: float) -> void:
	rotation = dir.angle()
	velocity = dir * speed
	move_and_slide()


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		queue_free()
		player.hurt(hurt)


func _on_timer_timeout() -> void:
	queue_free()
