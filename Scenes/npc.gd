extends CharacterBody2D

class_name NPC

# Se dispara cuando el npc habla
signal encuentro(npc)
signal update_registro

var nombre = ''
var dominio = ''
var focused = false
var seleccionado = false
var hablando = false
var cerca = false
var interactuando = false

var guid : String

@export var DEBUG = true
var COLORES = {
	'arte': Color.RED,
	'progreso': Color.AQUA,
	'naturaleza': Color.WEB_PURPLE
}

# La velocidad de desplazamiento
var speed = 60

# Variable que tiene el NPC al que este está yendo
var yendo_a: NPC = null

var move = false
var dest : Vector2
var vel = Vector2(0,0)

func _ready() -> void:
	guid = generate_guid()
	$AnimatedSprite2D.play("idle")
	if dominio:
		pasear()
	
func generate_guid():
	var random_part = str(randi(), "_",randi()) 
	var timestamp_part = str(Time.get_time_string_from_system())   # Timestamp (tiempo actual en segundos desde el 1 de enero de 1970)
	
	return random_part + "_" + timestamp_part  # Combinamos la parte aleatoria con el timestamp para asegurar unicidad
  
# Simbolos que tiene y quiere. Contiene símbolos enteros: objeto con 'imagen', 'nombre' y 'dominio'
var tiene = []
var quiere = []
var aborrece = []

@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _process(delta: float) -> void:
	queue_redraw()
	$Label.text = nombre
	
	# Sincronizamos el shader outline con la variable `seleccionado`
	$AnimatedSprite2D.material.set_shader_parameter("seleccionado", seleccionado)
	
	if yendo_a:
		nav.target_position = yendo_a.position
		if position.distance_to(yendo_a.position) < 50:
			print("@npc ENCUENTRO!!!")
			encuentro.emit(self, yendo_a)
			yendo_a = null
	
	if not(interactuando) and not(cerca):
		var direction = (nav.get_next_path_position() - global_position).normalized()
		velocity = direction * speed
		move_and_slide()


# Al ponerle el mouse encima, habla si el juagdor está cerca

func _on_area_tooltip_mouse_entered() -> void:
	$FocusCircle.material.set_shader_parameter("active", true)
	focused = true
	if cerca and not(hablando):
		$Globito.desaparecer()
		hablando = true
		await $Tooltip.decir(tiene)
		await $Tooltip.preguntar(quiere)
		hablando = false

func _on_area_tooltip_mouse_exited() -> void:
	$FocusCircle.material.set_shader_parameter("active", false)
	focused = false

func _draw():
	#if focused:
		#draw_circle(Vector2.ZERO, 30, Color.WHITE, false)
		#$FocusCircle.material.set_shader_parameter("active", true)
	#else:
		#$FocusCircle.material.set_shader_parameter("active", false)
	if yendo_a:
		draw_line(Vector2.ZERO, to_local(yendo_a.position), Color.WHITE)
	if DEBUG:
		draw_line(Vector2.ZERO, to_local(nav.target_position), Color.GREEN)
		draw_circle(to_local(nav.target_position), 20, Color.GREEN)
		draw_circle(Vector2.ZERO, 45, COLORES[dominio])
		
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
	if event is InputEventMouseMotion:
		if self not in Globals.npcs:
			print("Primer hover en ", nombre)
			Globals.npcs.append(self)
			print("Updateado Globals.npcs a ", Globals.npcs)
			update_registro.emit()
			
	if event is InputEventMouseButton:				
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:		
			if seleccionado == false and Globals.player_selecteds < Globals.max_players_selected:
#				SELECT
				Globals.selected_npc = self				
				seleccionado = true
				$clickpersonaje.play()
			elif seleccionado == true:
#				DESELECT
				Globals.player_selecteds -= 1
				seleccionado = false
			else :
					$clickrebote.play()
			
func deshighlight():
	seleccionado = false		

func _on_target_paseo_timeout() -> void:
	pasear()
	
func pasear():
	if not(yendo_a):
		if randf() < 0.6:
			nav.target_position = Navegacion.point_propio(dominio)
		else: 
			nav.target_position = Navegacion.point_extranjero(dominio)
					

func ir_a(otro_npc):
	yendo_a = otro_npc


## Interacciones visuales
# Emociones disponibles: 'aburrimiento', 'amor', 'interrogación' o 'irritación'

func on_alienar(que):
	await $Tooltip.decir([que])
	await $Tooltip.emocionar("interrogacion")
	
func on_asombrar(que):
	await $Tooltip.decir([que])
	await $Tooltip.emocionar("amor")
	$burbujitanpc.hide()
	
func on_aborrecer(que):
	await $Tooltip.decir([que])
	await $Tooltip.emocionar("irritación")
	
func on_conversar(que):
	await $Tooltip.decir([que])
	await $Tooltip.emocionar("amor")
	$burbujitanpc.hide()
	
func on_sentenciar(que):
	await $Tooltip.decir([que])
	await $Tooltip.emocionar("aburrimiento")
	
func on_inspirar(que):
	await $Tooltip.decir([que])
	await $Tooltip.emocionar("amor")
	$burbujitanpc.hide()
	
