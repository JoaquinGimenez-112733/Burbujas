extends CharacterBody2D

const SPEED = 4
@export var is_player = false
@export var stat1 = "ಠ_ಠ"
@export var stat2 = "(•◡•) /"
@export var stat3 = "ᶘ ◕ᴥ◕ᶅ"
@export var footstep : AudioStream
var footsteps_array : Array = [0,2]

var seleccionado = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.zoom = Vector2(Globals.player_camera_zoom, Globals.player_camera_zoom)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
#Mapeo de controles, para el movimiento del personaje
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
#Acá hacemos que se ejecute el sonido de los pasos de el personaje
#Tiene que ser en el primer frame, si el personaje está idle no ejecuta el sonido
	if $AnimatedSprite2D.animation == "idle": return
	load_sfx(footstep)
	if $AnimatedSprite2D.frame in footsteps_array:
		%sfx_player.play()
	
func _on_mouse_entered() -> void:
	print("Activando...")
	$Tooltip.activar(stat1, stat2, stat3)

func _on_mouse_exited() -> void:
	$Tooltip.cerrar()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:	
#En esta funcion capturamos el click sobre el personaje para enviarle el booleano "Seleccionado" al shader
#El shader alterna el outline segun esta variable
	if event is InputEventMouseButton:				
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:		
			if seleccionado == false and Globals.player_selecteds < Globals.max_players_selected:
#				SELECT
					
				Globals.player_selecteds += 1	
				print(Globals.player_selecteds)				
				self.seleccionado = true
				$AnimatedSprite2D.material.set_shader_parameter("seleccionado", seleccionado)
			elif seleccionado == true:
#				DESELECT
				Globals.player_selecteds -= 1
				self.seleccionado = false
				$AnimatedSprite2D.material.set_shader_parameter("seleccionado", seleccionado)

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Npc"):
		var nombre	 = body.get("nombre")
		Globals.npcs.append(nombre)
