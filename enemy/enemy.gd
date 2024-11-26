extends CharacterBody2D
class_name Enemy

@onready var anim = $AnimatedSprite2D
@onready var hp_bar = $hpBar
@onready var hurt_text = preload("res://hurt/hurt.tscn")
@onready var timer_attack_cd = $timer_attack_cd
@onready var anim_player = $AnimationPlayer
@onready var attack_effect_area = $attack_effect_area

var dir = Vector2.ONE
var speed = 100
var player : Player = null
var max_hp = 1000
var hurt = 40
var hp = max_hp
var isDead = false
var isCanAttack = false
var isCanWalk = true
var isDirRight = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_effect_area.monitoring = false
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDead:
		return
	if isCanWalk:
		walk()
	change_dir()
	move_and_slide()
	pass

func change_dir():
	anim.flip_h = dir.x < 0
	if dir.x < 0:
		attack_effect_area.scale.x = -1
	else :
		attack_effect_area.scale.x = 1
	pass

func walk():
	anim.play("run")
	dir = (player.global_position - global_position).normalized()
	velocity = dir * speed
	
func attack():
	anim.play("attack")
	velocity = Vector2.ZERO
	await get_tree().create_timer(0.2).timeout
	attack_effect_area.monitoring = true
	pass
	
func hurted(hurt: int, position: Vector2) -> bool:
	if isDead:
		return false
	hp -= hurt
	hp_bar.value = 100 * hp / max_hp
	var hurt_text_obj: HurtText = hurt_text.instantiate()
	add_child(hurt_text_obj)
	hurt_text_obj.set_text(str(hurt))
	hurt_text_obj.global_position = global_position
	if hp > 0: 
		GameMain.anim.play_anim({
			"box": self,
			"ani_name": "enemy_hurt",
			"position": Vector2.ONE,
			"scale": Vector2(5, 5)
		})
		#anim.play("hurt")
		global_position -= (position - global_position).normalized() * hurt / 10
	else : 
		#似了
		isDead = true
		#GameMain.anim.play_anim({
			#"box": get_tree().root,
			#"ani_name": "enemy_dead",
			#"position": global_position,
			#"scale": Vector2(10, 10)
		#})
		anim.play("dead")
		GameMain.drop_item.create_drop_item({
			"box": get_tree().root,
			"ani_name": "exp",
			"position": global_position,
			"scale": Vector2(3, 3)
		})
		hp_bar.hide()
		await get_tree().create_timer(1).timeout
		queue_free()
		return true
	return false


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		isCanAttack = true
		isCanWalk = false
		timer_attack_cd.start()
		attack()
	pass # Replace with function body.


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		isCanAttack = false
	pass # Replace with function body.


func _on_attack_cd_timeout() -> void:
	attack_effect_area.monitoring = false
	await get_tree().create_timer(0.3).timeout
	if isCanAttack:
		attack()
	else: 
		isCanWalk = true
	pass # Replace with function body.


func _on_attack_effect_area_body_entered(body: Node2D) -> void:
	print("被攻击")
	player.hp -= hurt
	pass # Replace with function body.
