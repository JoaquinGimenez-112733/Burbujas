extends CharacterBody2D

var focused = false

var hablando = false
var tiene = ['a', 'b']
var quiere = ['c']
var seleccionado = false

func _process(delta: float) -> void:
	queue_redraw()

func _ready():
	$AnimatedSprite2D.play("idle")

func _on_area_tooltip_mouse_entered() -> void:
	focused = true
	if not(hablando):
		hablando = true
		await $Tooltip.decir(tiene)
		await $Tooltip.preguntar(quiere)
		hablando = false

func _on_area_tooltip_mouse_exited() -> void:
	focused = false

func _draw():
	if focused:
		draw_circle(Vector2.ZERO, 30, Color.WHITE, false)


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
			elif seleccionado == true:
#				DESELECT
				Globals.player_selecteds -= 1
				self.seleccionado = false
				$AnimatedSprite2D.material.set_shader_parameter("seleccionado", seleccionado)
