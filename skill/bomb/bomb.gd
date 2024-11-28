extends BaseNode2D

class_name Bomb

@onready var timer : Timer = $Timer
@onready var area : Area2D = $Area2D
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D


var attack_enemies : Array[Enemy] = []
var fps = 1
var add_hp = 0
var add_attack = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	await get_tree().create_timer(0.3).timeout
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func big(ratio):
	scale *= ratio

func fast(ratio):
	fps *= ratio
	timer.wait_time = fps
	anim.speed_scale = 1/fps
	

func _on_timer_timeout() -> void:
	print(attack_enemies)
	for enemy in attack_enemies:
		var isDead = await enemy.hurted(player.max_hp / 10 + player.attack, global_position)
		if isDead:
			player.add_max_hp(add_hp)
			player.attack += add_attack
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		attack_enemies.append(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy && attack_enemies.has(body):
		attack_enemies.pop_at(attack_enemies.find(body))
	pass # Replace with function body.
