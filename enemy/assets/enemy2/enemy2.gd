extends Enemy
class_name Enemy2

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var hp_bar = $hpBar
@onready var hurt_text = preload("res://hurt/hurt.tscn")
@onready var timer_attack_cd = $timer_attack_cd
@onready var attack_effect_area = $attack_effect_area
@onready var bullet_tscn = preload("res://bullet/bullet.tscn")

var dir = Vector2.ONE
var speed = 100
var max_hp = 1000
var hurt = 10
var hp = max_hp
var isCanWalk = true
var isDirRight = true
var isHavePlayer = false

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
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


func hurted(hurt: int, position: Vector2, flip: bool = false, power: int = 30) -> bool:
	anim.play("hurt")
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
			"position": Vector2.ZERO,
			"scale": Vector2(8, 8)
		})
		#anim.play("hurt")
		if flip:
			global_position += (position - global_position).normalized() * power
		else:
			global_position -= (position - global_position).normalized() * power
	else : 
		#似了
		#GameMain.anim.play_anim({
			#"box": get_tree().root,
			#"ani_name": "enemy_dead",
			#"position": global_position,
			#"scale": Vector2(10, 10)
		#})
		GameMain.anim.play_anim({
			"box": get_tree().root,
			"ani_name": "enemy_dead",
			"position": global_position,
			"scale": Vector2(8, 8)
		})
		GameMain.drop_item.create_drop_item({
			"box": get_tree().root,
			"ani_name": "exp",
			"position": global_position,
			"scale": Vector2(3, 3)
		})
		hp_bar.hide()
		queue_free()
		return true
	return false


func _on_attack_effect_area_body_entered(body: Node2D) -> void:
	if body is Player:
		isHavePlayer = true
		isCanWalk = false
		attack()

func _on_attack_effect_area_body_exited(body: Node2D) -> void:
	if body is Player:
		isHavePlayer = false
		isCanWalk = true
		anim.play("run")
		

func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.animation == "attack" && anim.frame == 2 && isHavePlayer:
		var bullet : Bullet = bullet_tscn.instantiate()
		add_child(bullet)
		bullet.hurt = hurt
		bullet.dir = (player.global_position - global_position).normalized()
		
