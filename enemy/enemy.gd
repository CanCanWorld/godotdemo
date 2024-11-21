extends CharacterBody2D
class_name Enemy

@onready var anim = $AnimatedSprite2D
@onready var hp_bar = $hpBar
@onready var hurt_text = preload("res://hurt/hurt.tscn")

var dir = Vector2.ONE
var speed = 100
var player : Node2D = null
var max_hp = 100
var hp = max_hp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dir = (player.global_position - global_position).normalized()
	velocity = dir * speed
	anim.flip_h = dir.x < 0
	move_and_slide()
	pass
	
func induce_hp(hurt: int, position: Vector2) -> void:
	hp -= hurt
	hp_bar.value = 100 * hp / max_hp
	var hurt_text_obj: HurtText = hurt_text.instantiate()
	add_child(hurt_text_obj)
	hurt_text_obj.set_text(str(hurt))
	hurt_text_obj.global_position = global_position
	GameMain.anim.play_anim({
		"box": self,
		"ani_name": "enemy_hurt",
		"position": Vector2.ONE,
		"scale": Vector2(5, 5)
	})
	global_position -= (position - global_position).normalized() * hurt * 3
	if hp <= 0: 
		GameMain.anim.play_anim({
			"box": get_tree().root,
			"ani_name": "enemy_dead",
			"position": global_position,
			"scale": Vector2(10, 10)
		})
		GameMain.drop_item.create_drop_item({
			"box": get_tree().root,
			"ani_name": "exp",
			"position": global_position,
			"scale": Vector2(3, 3)
		})
		queue_free()
