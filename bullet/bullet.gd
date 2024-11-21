extends CharacterBody2D

class_name Bullet

@onready var bullet_anim = $BulletAnim
var dir = Vector2.ZERO
var speed = 1000
var hurt = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var randi = randi_range(1,6)
	#choosePlayer('bullet' + String.num(randi))
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


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMap:
		var coords = body.get_coords_for_body_rid(body_rid)
		var tile_data : TileData = body.get_cell_tile_data(2, coords)
		var isWall : bool = tile_data.get_custom_data("isWall")
		if isWall:
			queue_free()
	if body.is_in_group("enemy"):
		queue_free()
		var enemy = body as Enemy
		enemy.induce_hp(hurt, global_position)
	pass # Replace with function body.
