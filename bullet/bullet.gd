extends CharacterBody2D

class_name Bullet

@onready var bullet_anim = $BulletAnim
var dir = Vector2.ZERO
var speed = 1000
var hurt = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var randi = randi_range(1,6)
	choosePlayer('bullet' + String.num(randi))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = dir * speed
	move_and_slide()
	pass


	
func choosePlayer(name: String):
	bullet_anim.sprite_frames.clear_all()
	var sprite_frames_custom = SpriteFrames.new()
	sprite_frames_custom.add_animation("default")
	sprite_frames_custom.set_animation_loop("default", true	)
	var texture_size = Vector2(183, 183)
	var full_texture = load("res://bullet/assets/" + name + "/bullet.png")
	var frame = AtlasTexture.new()
	frame.atlas = full_texture
	sprite_frames_custom.add_frame("default", frame)
	bullet_anim.sprite_frames = sprite_frames_custom
	pass
