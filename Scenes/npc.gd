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
	$Label.text = nombre
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
	#if move:
	#	move_npc(delta)
	queue_redraw()
	
	if yendo_a:
		nav.target_position = yendo_a.position
		if position.distance_to(yendo_a.position) < 50:
			yendo_a = null
			#interactuar()
	
	var direction = (nav.get_next_path_position() - global_position).normalized()
	
	velocity = direction * speed

	move_and_slide()


# Al ponerle el mouse encima, habla si el juagdor está cerca

func _on_area_tooltip_mouse_entered() -> void:
	$FocusCircle.material.set_shader_parameter("active", true)
	focused = true
	if cerca and not(hablando):
		encuentro.emit(self)
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
		##draw_circle(Vector2.ZERO, 30, Color.WHITE, false)
		#$FocusCircle.material.set_shader_parameter("active", true)
	#else:
		#$FocusCircle.material.set_shader_parameter("active", false)
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
		var nombre = self.nombre
		if nombre not in Globals.npcs:				
			var animated_sprite = $AnimatedSprite2D
			if animated_sprite:						
				var frame = animated_sprite.get_frame()
				var texture = animated_sprite.sprite_frames.get_frame_texture("idle_small", 0)
				var quiere = self.quiere
				var tiene = self.tiene				
				var miniatura : Texture2D = texture
				Globals.miniaturas.append(miniatura)
				var array_total : Array
				array_total.append_array(quiere)
				array_total.append_array(tiene)
				var item = Item_Sidebar.new(miniatura, nombre, array_total, self.global_position, guid)
				Globals.items_sidebar.append(item)
				Globals.npcs.append(self)
	if event is InputEventMouseButton:				
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:		
			if seleccionado == false and Globals.player_selecteds < Globals.max_players_selected:
#				SELECT
				Globals.selected_npc = self				
				seleccionado = true
				$AnimatedSprite2D.material.set_shader_parameter("seleccionado", seleccionado)
				$clickpersonaje.play()
			elif seleccionado == true:
#				DESELECT
				Globals.player_selecteds -= 1
				seleccionado = false
				$AnimatedSprite2D.material.set_shader_parameter("seleccionado", seleccionado)
			else :
					$clickrebote.play()
					

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

	
