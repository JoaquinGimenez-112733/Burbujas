extends Sprite2D

func _ready() -> void:
	modulate = Color.TRANSPARENT
	mover()

func mover():
	await get_tree().create_timer(0.6).timeout
	position.y = -15
	await get_tree().create_timer(0.6).timeout
	position.y = -10

func aparecer():
	create_tween().tween_property(self, "modulate", Color.WHITE, 0.6)

func desaparecer():
	create_tween().tween_property(self, "modulate", Color.TRANSPARENT, 0.6)
