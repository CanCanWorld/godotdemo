extends BaseNode2D

class_name Bomb

@onready var area : Area2D = $Area2D
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D


var attack_enemies : Array[Enemy] = []
var add_hp = 0
var add_attack = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func big(ratio):
	scale *= ratio

func fast(ratio):
	anim.speed_scale *= ratio


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		attack_enemies.append(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy && attack_enemies.has(body):
		attack_enemies.pop_at(attack_enemies.find(body))
	pass # Replace with function body.


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.frame != 15:
		return
	for enemy in attack_enemies:
		var isDead = await enemy.hurted(player.max_hp / 20 + player.attack, global_position)
		if isDead:
			player.add_max_hp(add_hp)
			player.attack += add_attack
