extends CharacterBody2D

var focused = false

var simbolos = ['a', 'b', 'c']

func _process(delta: float) -> void:
	queue_redraw()

func _ready():
	$AnimatedSprite2D.play("idle")

func _on_area_tooltip_mouse_entered() -> void:
	focused = true
	#$Tooltip.ubicar(get_global_mouse_position())
	$Tooltip.activar('hola', 'holi', 'holu')

func _on_area_tooltip_mouse_exited() -> void:
	focused = false
	$Tooltip.cerrar()

func _draw():
	if focused:
		draw_circle(Vector2.ZERO, 30, Color.WHITE, false)
