extends CharacterBody2D

const SPEED = 3
@export var is_player = false
@export var stat1 = "ಠ_ಠ"
@export var stat2 = " (•◡•) /"
@export var stat3 = "ᶘ ◕ᴥ◕ᶅ"
@export var footstep : AudioStream
var footsteps_array : Array = [0,3]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Tooltip.tooltip_text = stat1 + "\n" + stat2 + "\n" + stat3
	pass


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
		$AnimatedSprite2D.play("idle")		

func load_sfx(sfx_to_load):
	if %sfx_player.stream != sfx_to_load:
		%sfx_player.stop()
		%sfx_player.stream = sfx_to_load
		
func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.animation == "idle": return
	load_sfx(footstep)
	if $AnimatedSprite2D.frame in footsteps_array:
		%sfx_player.play()
	


func _on_tooltip_mouse_entered() -> void:
	$Tooltip/PopupPanel/VBoxContainer/Label.text = stat1
	$Tooltip/PopupPanel/VBoxContainer/Label2.text = stat2
	$Tooltip/PopupPanel/VBoxContainer/Label3.text = stat3
	$Tooltip/PopupPanel.popup()


func _on_tooltip_mouse_exited() -> void:
	$Tooltip/PopupPanel.hide()
