extends CharacterBody2D

class_name NPC

# Se dispara cuando el npc habla
signal encuentro(npc)

var nombre = ''
var dominio = ''
var focused = false
var seleccionado = false
var hablando = false
var cerca = false

var DEBUG = true

# La velocidad de desplazamiento
var speed = 100

# Simbolos que tiene y quiere. Contiene símbolos enteros: objeto con 'imagen', 'nombre' y 'dominio'
var tiene = []
var quiere = []
var aborrece = []

@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _process(delta: float) -> void:
	queue_redraw()
	
	var direction = (nav.get_next_path_position() - global_position).normalized()
	
	velocity = direction * speed
	
	move_and_slide()

func _ready():
	$AnimatedSprite2D.play("idle")
	$Label.text = nombre
	pasear()

# Al ponerle el mouse encima, habla si el juagdor está cerca

func _on_area_tooltip_mouse_entered() -> void:
	focused = true
	if cerca and not(hablando):
		encuentro.emit(self)
		$Globito.desaparecer()
		hablando = true
		await $Tooltip.decir(tiene)
		await $Tooltip.preguntar(quiere)
		hablando = false

func _on_area_tooltip_mouse_exited() -> void:
	focused = false

func _draw():
	if focused:
		draw_circle(Vector2.ZERO, 30, Color.WHITE, false)
	if DEBUG:
		draw_line(Vector2.ZERO, to_local(nav.get_next_path_position()), Color.GREEN)

# Al entrar o salir del area de "Influencia", 
# seteamos la variable `cerca`
func _on_influencia_body_entered(body: Node2D) -> void:
	if body is Player: 
		cerca = true
		$Globito.aparecer()
		
func _on_influencia_body_exited(body: Node2D) -> void:
	if body is Player:
		cerca = false
		$Globito.desaparecer()

func _on_area_tooltip_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
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
				$clickpersonaje.play()
			elif seleccionado == true:
#				DESELECT
				Globals.player_selecteds -= 1
				self.seleccionado = false
				$AnimatedSprite2D.material.set_shader_parameter("seleccionado", seleccionado)
			else :
					$clickrebote.play()
			


func _on_target_paseo_timeout() -> void:
	pasear()
	
func pasear():
	if randf() < 0.8:
		nav.target_position = Navegacion.point_propio(dominio)
	else: 
		nav.target_position = Navegacion.point_extranjero(dominio)
