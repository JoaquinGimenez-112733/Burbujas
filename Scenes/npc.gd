extends CharacterBody2D

class_name NPC

var focused = false
var hablando = false
var cerca = false

# Simbolos que tiene y quiere
var tiene = []
var quiere = []

func _process(delta: float) -> void:
	queue_redraw()

func _ready():
	$AnimatedSprite2D.play("idle")

# Al ponerle el mouse encima, habla si el juagdor está cerca
func _on_area_tooltip_mouse_entered() -> void:
	focused = true
	if cerca and not(hablando):
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
