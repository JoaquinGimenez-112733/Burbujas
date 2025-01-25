extends CharacterBody2D

const SPEED = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("UP"):
		position.y -= 1 * SPEED
		$AnimatedSprite2D.play("walk_up")
	elif Input.is_action_pressed("DOWN"):
		position.y += 1 * SPEED
		$AnimatedSprite2D.play("walk_down")
	elif Input.is_action_pressed("LEFT"):
		position.x -= 1 * SPEED
		$AnimatedSprite2D.play("walk_h")
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("RIGHT"):
		position.x += 1 * SPEED
		$AnimatedSprite2D.play("walk_h")
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.stop()
